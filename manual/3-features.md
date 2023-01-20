# Features

## System overview

The BMS is the heart of every Li-ion battery. It is needed to equalize series connected cells and protect the battery from current, voltages and temperatures outside the allowed operating range.

Below figure shows a complete battery system with the integrated BMS.

![Overview of the BMS integrated into a Li-ion battery pack.](./images/bms-overview.svg)

This BMS has the following high-level features:

- Flexible and fully Open Source design
- Suitable for 12V, 24V or 48V systems (up to 16 LFP cells in series)
- Continuous currents of up to 100A

With above specifications it is suitable for the following applications:

- Poductive use appliances like milling machines
- Energy storage for AC mini-grid applications with up to 4 kVA inverters
- Second-life batteries built e.g. from recycled EV batteries
- Generic off-grid energy storage e.g. in caravans

## Hardware

![BMS Overview](./images/bms-c1_overview.svg)

### Board design

All electronics components (power and control) are integrated into a single PCB in order to reduce cost and size.

The board contains the following main subsystems:

- Power part (top left)
  - High current terminals
  - MOSFETs (4 in parallel, 2 in series for bi-directional switching)
  - Current measurement shunt

- Control part (bottom right)
  - Microcontroller: ESP32-C3
  - BMS ASIC: Texas Instruments BQ76952
  - Internal power supply
  - Communication interfaces (CAN, UART, I2C, USB, Bluetooth)

### MCU: ESP32-C3

The [Espressif ESP32-C3](https://www.espressif.com/en/products/socs/esp32-c3) is a single-core microcontroller featuring Wi-Fi, Bluetooth 5 (LE) and CAN (called TWAI by Espressif). It is based on the open-source RISC-V architecture.

### BMS IC: BQ76952

The [Texas Instruments BQ76952](https://www.ti.com/product/BQ76952) was selected as the BMS IC as it offers a good compromise between accuracy, features and cost.

Features according to Datasheet:

- Battery monitoring capability for 3-series to 16-series cells
- Integrated charge pump for high-side NFET protection with optional autonomous recovery
- Extensive protection suite including voltage, temperature, current, and internal diagnostics
- Two independent ADCs
- Support for simultaneous current and voltage sampling
- High-accuracy coulomb counter with input offset error < 1 uV (typical)
- High accuracy cell voltage measurement < 10 mV (typical)
- Wide-range current applications (±200-mV measurement range across sense resistor)
- Integrated secondary chemical fuse drive protection
- Autonomous or host-controlled cell balancing
- Multiple power modes (typical battery pack operating range conditions)
- NORMAL mode: 286 uA
- Multiple SLEEP mode options: 24 uA to 41 uA
- Multiple DEEPSLEEP mode options: 9 uA to 10 uA
- SHUTDOWN mode: 1 uA
- High-voltage tolerance of 85 V on cell connect and select additional pins
- Tolerant of random cell attach sequence on production line
- Support for temperature sensing using internal sensor and up to nine external thermistors
- Integrated one-time-programmable (OTP) memory programmable by customers on production line
- Communication options include 400-kHz I2C, SPI, and HDQ one-wire interface
- Dual-programmable LDOs for external system usage
- 48-pin TQFP package (PFB)

### Balancing

The BMS features passive balancing with up to 100 mA.

### Protective switches

The positive battery terminal can be disconnected by the BMS for safety reasons or upon demand of the user via a communicatoin interface.

The disconnect switches are N-channel MOSFETs in a back-to-back configuration to be able to interrupt current in both directions (see also BQ76952 datasheet). In order to allow the high currents, 4 MOSFETs are connected in parallel.

The bottom side of the PCB can be attached to a heat sink to dissipate the heat at high continuous currents.

The cell connector has a pin to trigger a fuse at the pack positive terminal as a secondary protection if the MOSFETs fail short.

### Current measurement

The current is measured using a shunt, located in the negative voltage path of the battery pack. The shunt voltage is amplified by the BQ76952 ASIC and read by the MCU.

Time-critical safety features like overcurrent and short circuit protection are implemented directly in the ASIC and can be calibrated via firmware.

### Cell and thermistor connectors

The cells and thermistors are connected to the BMS using [Molex Micro-Fit](https://www.molex.com/molex/products/family/microfit_30) or [Würth WR-MPC3](https://www.we-online.com/katalog/en/em/connectors/wire-to-board/wr_mpc3) series connectors.

Both series are pin-compatible and there are even more compatible connectors in the market for this popular series. The connectors can handle up to 5A, which is sufficient even for active balancing.

### Power connectors

The BMS is designed for up to 100A continuous current, depending on ambient temperatures, heat sink and actually fitted MOSFETs.

Würth high-power solder terminals with M5 threads are used for wire-to-board connections.

## Communication interfaces

One major advantage of an Open Source design is its extensibility and adaptation to specific requirements.

In order to provide the hardware interfaces required to add custom extensions, two options are offered. Communication between multiple BMSs or other devices like charge controllers can be achieved via CAN bus, while the addional interfaces like I2C and UART can be used for extension of the board with internal features like displays.

The MCU features built-in WiFi and Bluetooth communication.

The serial and Bluetooth communication interfaces use the [ThingSet protocol](https://thingset.io/) by default, which allows to read measurement values from the BMS as well as store custom configuration.

## Firmware

The firmware is based on [Zephyr RTOS](https://www.zephyrproject.org/) and thus allows for easy integration of additional communication features. The latest Zephyr long-term support release is in the process of being certified for functional safety according to IEC 61508.

Amongst all features inherited from underlying Zephyr, the BMS firmware has the additional BMS-specific features:

- Monitoring and configuration using the [ThingSet](https://thingset.io/) protocol (mapping to MQTT, CoAP and HTTP possible)
  - Serial interface
  - CAN bus
  - I2C
  - Bluetooth
  - WiFi
- SOC estimation based on coulomb counting
- Configuration options
  - Pack layout
    - Cell chemistry (LiFePO4, NMC, NCA)
    - Nominal capacity
    - Number of cells
    - Thermistor type
    - Shunt resistor
    - Custom open circuit voltage (OCV) look-up table
  - Protection
    - Discharge short circuit limit (A)
    - Discharge short circuit delay (us)
    - Discharge over-current limit (A)
    - Discharge over-current delay (ms)
    - Charge over-current limit (A)
    - Charge over-current delay (ms)
    - Cell target charge voltage (V)
    - Cell discharge voltage limit (V)
    - Cell over-voltage limit (V)
    - Cell over-voltage error reset threshold (V)
    - Cell over-voltage delay (ms)
    - Cell under-voltage limit (V)
    - Cell under-voltage error reset threshold (V)
    - Cell under-voltage delay (ms)
    - Discharge over-temperature (DOT) limit (°C)
    - Discharge under-temperature (DUT) limit (°C)
    - Charge over-temperature (COT) limit (°C)
    - Charge under-temperature (CUT) limit (°C)
    - Temperature limit hysteresis (°C)
  - Balancing
    - Enable automatic balancing.
    - Balancing cell voltage target difference (V)
    - Minimum cell voltage to start balancing (V)
    - Current threshold to be considered idle (A)
    - Minimum idle duration before balancing (s)
