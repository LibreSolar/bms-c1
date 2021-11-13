# BMS 16S100 SC

![Development Stage](https://img.shields.io/badge/development%20stage-alpha-red.svg) Very early and incomplete development stage.

This repository contains the files for ongoing development of the Libre Solar BMS 16S100 SC.

The project is funded by the [EnAccess foundation](https://enaccess.org).

Technical specification: [spec folder](./spec/) (work in progress)

## Features:

- 3 to 16 Li-ion cells in series (using bq76952)
- Integrated high-side MOSFET switch and current sensor
- STM32G0B1 or ESP32 microcontroller
- Support for different cell chemistries including LiFePO4 and NMC
- Built-in CAN communication interface and UEXT extension connector

## Firmware

The firmware is developed in a separate repository [LibreSolar/bms-firmware](https://github.com/LibreSolar/bms-firmware).

## License

The hardware is licensed under the [CERN Open Hardware Licence Version 2 - Weakly Reciprocal](LICENCE).

Documentation is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) License](https://creativecommons.org/licenses/by-sa/4.0/).
