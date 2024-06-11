# Installation

**Attention**: The maximum operating voltage of the BMS is 60V. The 16s configuration is only feasible for LFP cells. For NMC cells, a maximum number of 14 cells may be used.

## Mechanical Design

The board dimensions are 70x135 mm² so that it can be easily integrated into existing housings with typical 18650 or 2170 cells.

![BMS mounted on a heat sink](./images/bms-c1_heatsink.svg)

Depending on the current requirements and ambient temperatures, a heat sink may be required. For good thermal contact, a thermal interface material (e.g. Henkel/Bergquist GAP PAD A2000) is required, as shown in above picture.

## Connections

Below picture shows the connections of the cells, the 10k thermistors (NTC1 and NTC2) and the high power cables.

![BMS connections](./images/bms-c1_connections.svg)

The BMS is powered through the BAT+ terminal. If only the cell connector is mounted, the power is provided through the additional BAT+ wire in the cell connector, which has to be connected to the last cell's positive terminal.

The BMS cannot be powered through the USB port only.

### Power connections

The high power terminals have an M5 thread and allow to fit wires of up to 35 mm² cross-section.

The nuts and washers should be made from stainless steel to avoid corrosion with copper cable lugs.

The wires must be properly fixed in the housing to reduce stress on the soldered terminals on the PCB.

The fixing torque for the nuts is 2.2 Nm. Use of a torque wrench is highly recommended.

### Signal connections

The MPC3 / Microfit connector must be equipped with properly crimped wires connected to the cells and the thermistors. Würth sells [pre-crimped wires](https://www.we-online.com/de/components/products/em/connectors/wire-to-board/wr_mpc3/wr_mpc3_pre_crimped_wire) so that no crimping tool is needed (the low-force type is recommended). These wires can be cut in half and connected to the application specific wiring harness.

The first signal connection and the very last one (respectively shown in grey and orange in the connection diagram) are used for powering up the BMS. 
If less than 16 cells are used :  
- Route the last wire of the harness (shown in orange) to the before last Microfit pin.
- Short the unused cell connections: 
  - on the PCB using the exposed pads as per the schematic below in cyan
  - or in the wiring harness directly. 

![BMS connections](./images/bms-c1_connections_12s.svg)

See also the [BQ76952 documentation](https://www.ti.com/product/BQ76952) for further details.

At least NTC1 has to be connected and show a valid temperature range for the BMS to allow charging/discharging.

### Connection order

1. Connect the fully wired cell connector. (Note the two separate connections to the first cell's negative terminal)
2. Connect the BAT- terminal.
3. Connect the BAT+ terminal (with a fuse in line, as shown).
4. Connect load or charger.

## Communication ports

The CAN, UART and I2C communication ports use JST PH connectors. The pinout is marked on the PCB.

The I2C is shared with the BQ76952. It must be ensured that this communication is not disturbed by another component on the I2C bus.
