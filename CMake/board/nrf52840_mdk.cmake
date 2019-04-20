set(nrf52840_mdk_DEFINES
    -DBOARD_CUSTOM
    -DNRF52840_MDK
    -DCONFIG_GPIO_AS_PINRESET)

set(nrf52840_mdk_INCLUDE_DIRS
    "${SDK_ROOT}/components/boards"
    "${SDK_ROOT}/../../config")