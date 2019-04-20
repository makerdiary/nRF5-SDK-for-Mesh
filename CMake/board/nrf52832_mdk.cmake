set(nrf52832_mdk_DEFINES
    -DBOARD_CUSTOM
    -DNRF52832_MDK
    -DCONFIG_GPIO_AS_PINRESET)

set(nrf52832_mdk_INCLUDE_DIRS
    "${SDK_ROOT}/components/boards"
    "${SDK_ROOT}/../../config")
