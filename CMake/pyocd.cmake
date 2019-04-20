find_program(PYOCD
    pyocd)

find_program(MERGEHEX
    mergehex)

if (PLATFORM STREQUAL "nrf51422_xxAC")
    set(PYOCD_TARGET "nrf51" CACHE STRING "Set the target type.")
elseif (PLATFORM STREQUAL "nrf52810_xxAA")
    set(PYOCD_TARGET "nrf52" CACHE STRING "Set the target type.")
elseif (PLATFORM STREQUAL "nrf52832_xxAA")
    set(PYOCD_TARGET "nrf52" CACHE STRING "Set the target type.")
elseif (PLATFORM STREQUAL "nrf52840_xxAA")
    set(PYOCD_TARGET "nrf52840" CACHE STRING "Set the target type.")
else()
    message(FATAL_ERROR "Target for platform ${PLATFORM} not defined.")
endif ()


if (PYOCD AND MERGEHEX AND PYTHON_EXECUTABLE)
    add_custom_target(merge)
    function(add_flash_target target)
        # Both the manual <merge> and <flash> target and depends on
        # the custom command that generates the merged hexfile.
        add_custom_target(merge_${target}
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_dependencies(merge merge_${target})

        add_custom_target(flash_${target}
            COMMAND ${PYOCD} flash -t ${PYOCD_TARGET} -e chip -v
            ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex
            USES_TERMINAL
            DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex)

        add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex
            COMMAND ${MERGEHEX} -m ${${SOFTDEVICE}_HEX_FILE} ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex -o ${CMAKE_CURRENT_BINARY_DIR}/${target}_merged.hex
            DEPENDS ${target}
            VERBATIM)
    endfunction(add_flash_target)
else ()
    message(STATUS "Could not find command line tools (`mergehex` and `pyocd`).
   See http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.tools/dita/tools/nrf5x_command_line_tools/nrf5x_installation.html?cp=5_1_1 and https://github.com/mbedmicro/pyOCD
   Flash target will not be supported.")
    function(add_flash_target target)
        # Not supported
    endfunction(add_flash_target)
endif (PYOCD AND MERGEHEX AND PYTHON_EXECUTABLE)