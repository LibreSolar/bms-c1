# Operation

## Firmware flashing

If no firmware is flashed on the board, make sure the board is powered through the cell connector. The power wires BAT+ and BAT- are optional.

The firmware is flashed through the USB port. Follow the instructions in the [Firmware repository](https://github.com/LibreSolar/bms-firmware).

## Start-up

In order to wake up the BMS chip, short-press the ON/OFF button S1 (top-right corner).

If the button is long-pressed for at least 3 seconds, the BMS will go into low-power shutdown mode.

A custom push-button as part of the battery housing can be connected to the connector J5 next to the button.

## LED indications

The BMS is equipped with two status LEDs with below indications:

Red LED:

| Status | Meaning |
|---------|--------|
| off     | Discharging finished and battery is empty |
| on      | Discharging allowed (current below idle threshold) |
| blinking slowly | Discharging active (current above idle threshold) |
| flashing quickly | Discharging error (UV/OT/UT/OC/SC) |

Green LED:

| Status | Meaning |
|---------|--------|
| off     | Charging finished and battery is full |
| on      | Charging allowed (current below idle threshold) |
| blinking slowly | Charging active (current above idle threshold) |
| flashing quickly | Charging error (OV/OT/UT/OC) |

## Communication Setup

Device information, configuration values and measurements can be explored using the [ThingSet protocol](https://thingset.io/). This protocol is used for the serial interface as well as the Bluetooth communication.

For details regarding the protocol consider the specification linked above. The basic setup is explained below.

### USB Serial

The USB virtual COM port exposes log data and the Zephyr shell. Among other commands, the shell can also be used for communication using the ThingSet protocool.

A terminal program like `picocom` is recommended:

```
picocom /dev/ttyACM0
```

The shell command for the ThingSet protocol is `thingset`. Either prefix it for every command or `select thingset` to switch into ThingSet mode.

```
select thingset
?Meas
:85 {"rPackVoltage_V":13.71,"rStackVoltage_V":13.91,"rPackCurrent_A":0.05,"rBatTemp_degC":29.4,"rICTemp_degC":34.2,"rMOSFETTemp_degC":31.8,"rSOC_pct":100.0,"rErrorFlags":0,"rBmsState":3,"rCellVoltages_V":[3.495,3.497,3.486,3.495,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000],"rCellAvgVoltage_V":3.493,"rCellMinVoltage_V":3.486,"rCellMaxVoltage_V":3.497,"rBalancingStatus":0}
```

When using the shell, the quotation marks in JSON data have to be escaped. See below for an example:

```
=Conf {\"sCellOvervoltage_V\": 3.8}
:84
```

### UART Serial

The serial interface uses a baud-rate of 115200 bps. Depending on the operating system, you can use different tools to communicate with the serial interface manually.

For Linux [CuteCom](https://sourceforge.net/projects/cutecom/) is recommended, as it stores a history of previous commands.

The [Serial2Websocket Python script](https://github.com/ThingSet/thingset-serial2websocket) can be used as a basis for own scripts to use the monitoring data.

### BLE

The generic [ThingSet app](https://github.com/ThingSet/thingset-app) can be used to connect to the BMS via Bluetooth LE.

For own developments see the BLE transport layer specification on the ThingSet website and consider the implementation of the device side in the [ThingSet Zephyr SDK](https://github.com/ThingSet/thingset-zephyr-sdk).

## Configuration

The ThingSet protocol itself allows to discover available data items for configuration, so this manual will only use some examples for demonstration purposes.

### Read measurements and battery status

Use the following command to get the current state of the battery, including all current, temperature and voltage measurements:

```
?Meas
```

### Configure battery type

The configuration for a particular cell type and battery size can be preset with suitable default values using the two executable data items `xPresetNMC` for NMC cells and `xPresetLFP` for LFP cells. The functions expect a parameter defining the nominal capacity of the battery in Ah.

For an LFP battery with 45 Ah, send the following command to the BMS:

```
!Conf/xPresetLFP [45]
```

The expected response if the parameters were successfully set:

```
:84 0
```

### Adjust thresholds

The current configuration can be determined with the following command:

```
?Conf
```

Individual parameters can be adjusted with a command as shown below (using the overvoltage threshold as an example):


```
=Conf {"sCellOvervoltage_V": 3.8}
```
