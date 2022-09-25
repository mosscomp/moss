# Connecting Over Serial Port

The `moss` UART can be used to send information between the system and the host
machine. There are a variety of utilities that can be used to connect over
serial port.

## Screen

```
screen /dev/ttyUSB1 9600
```

Kill screen:
```
CTRL+a k
```

## Minicom

Minicom can be configured using `minirc` files. The following configuration file
supports communicating with `moss`:

`minirc.moss`
```
# Machine-generated file - use "minicom -s" to change parameters.
pu port             /dev/ttyUSB1
pu baudrate         9600
pu rtscts           No 
```

## xxd

```
xxd -b < /dev/ttyUSB1
```
