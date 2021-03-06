set(target "my_light_switch_server_${PLATFORM}_${SOFTDEVICE}")

add_executable(${target}
    "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c"
    "${CMAKE_SOURCE_DIR}/examples/common/src/app_onoff.c"
    "${CMAKE_SOURCE_DIR}/mesh/stack/src/mesh_stack.c"
    "${CMAKE_SOURCE_DIR}/examples/common/src/mesh_provisionee.c"
    "${CMAKE_SOURCE_DIR}/examples/common/src/simple_hal.c"
    "${CMAKE_SOURCE_DIR}/examples/common/src/simple_uart_log.c"
    "${CMAKE_SOURCE_DIR}/examples/common/src/mesh_app_utils.c"
    ${BLE_SOFTDEVICE_SUPPORT_SOURCE_FILES}
    ${WEAK_SOURCE_FILES}
    ${MESH_CORE_SOURCE_FILES}
    ${MESH_BEARER_SOURCE_FILES}
    ${MESH_GATT_SOURCE_FILES}
    ${CONFIG_SERVER_SOURCE_FILES}
    ${HEALTH_SERVER_SOURCE_FILES}
    ${GENERIC_ONOFF_SERVER_SOURCE_FILES}
    ${ACCESS_SOURCE_FILES}
    ${MESH_APP_TIMER_SOURCE_FILES}
    ${PROV_PROVISIONEE_SOURCE_FILES}
    ${PROV_COMMON_SOURCE_FILES}
    ${PROV_BEARER_ADV_SOURCE_FILES}
    ${PROV_BEARER_GATT_SOURCE_FILES}
    ${${PLATFORM}_SOURCE_FILES}
    ${${nRF5_SDK_VERSION}_SOURCE_FILES}
    "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_gpiote.c"
    "${SDK_ROOT}/components/libraries/button/app_button.c"
    "${SDK_ROOT}/components/libraries/fifo/app_fifo.c"
    "${SDK_ROOT}/components/libraries/uart/app_uart_fifo.c"
    "${SDK_ROOT}/components/libraries/util/nrf_assert.c"
    "${SDK_ROOT}/components/libraries/atomic/nrf_atomic.c"
    "${SDK_ROOT}/components/libraries/balloc/nrf_balloc.c"
    "${SDK_ROOT}/external/fprintf/nrf_fprintf.c"
    "${SDK_ROOT}/external/fprintf/nrf_fprintf_format.c"
    "${SDK_ROOT}/components/libraries/memobj/nrf_memobj.c"
    "${SDK_ROOT}/components/libraries/ringbuf/nrf_ringbuf.c"
    "${SDK_ROOT}/components/libraries/strerror/nrf_strerror.c"
    "${SDK_ROOT}/components/libraries/uart/retarget.c"
    "${SDK_ROOT}/integration/nrfx/legacy/nrf_drv_uart.c"
    "${SDK_ROOT}/modules/nrfx/drivers/src/prs/nrfx_prs.c"
    "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uart.c"
    "${SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uarte.c")

target_include_directories(${target} PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../include"
    "${CMAKE_SOURCE_DIR}/examples/common/include"
    "${CMAKE_SOURCE_DIR}/external/rtt/include"
    ${BLE_SOFTDEVICE_SUPPORT_INCLUDE_DIRS}
    ${CONFIG_SERVER_INCLUDE_DIRS}
    ${HEALTH_SERVER_INCLUDE_DIRS}
    ${GENERIC_ONOFF_SERVER_INCLUDE_DIRS}
    ${MESH_INCLUDE_DIRS}
    ${${SOFTDEVICE}_INCLUDE_DIRS}
    ${${PLATFORM}_INCLUDE_DIRS}
    ${${BOARD}_INCLUDE_DIRS}
    ${${nRF5_SDK_VERSION}_INCLUDE_DIRS}
    "${SDK_ROOT}/components/libraries/gpiote"
    "${SDK_ROOT}/components/libraries/button"
    "${SDK_ROOT}/modules/nrfx/hal"
    "${SDK_ROOT}/integration/nrfx/legacy"
    "${SDK_ROOT}/modules/nrfx/drivers/include"
    "${SDK_ROOT}/components/libraries/fifo"
    "${SDK_ROOT}/components/libraries/strerror"
    "${SDK_ROOT}/components/libraries/balloc"
    "${SDK_ROOT}/components/libraries/ringbuf"
    "${SDK_ROOT}/components/libraries/memobj"
    "${SDK_ROOT}/components/libraries/uart"
    "${SDK_ROOT}/external/fprintf"
    "${SDK_ROOT}/components/libraries/atomic")

set_target_link_options(${target}
    ${CMAKE_CURRENT_SOURCE_DIR}/linker/${PLATFORM}_${SOFTDEVICE})

target_compile_options(${target} PUBLIC
    ${${ARCH}_DEFINES})

target_compile_definitions(${target} PUBLIC
    ${USER_DEFINITIONS}
    -DUSE_APP_CONFIG
    -DCONFIG_APP_IN_CORE
    ${${PLATFORM}_DEFINES}
    ${${SOFTDEVICE}_DEFINES}
    ${${BOARD}_DEFINES})

target_link_libraries(${target}
    rtt_${PLATFORM}
    uECC_${PLATFORM})

create_hex(${target})
add_flash_target(${target})

get_property(target_include_dirs TARGET ${target} PROPERTY INCLUDE_DIRECTORIES)
add_pc_lint(${target}
    "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c;${CMAKE_SOURCE_DIR}/examples/common/src/app_onoff.c"
    "${target_include_dirs}"
    "${${PLATFORM}_DEFINES};${${SOFTDEVICE}_DEFINES};${${BOARD}_DEFINES}")
add_ses_project(${target})
