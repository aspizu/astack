---
name: mobile-use
description: Control my mobile phone using adb.
---

The Pixel's Tailscale ADB address is `$ANDROID_ADB_ADDRESS`. If TCP mode needs
re-enabling, `adb -s "$ANDROID_USB_SERIAL" tcpip 5555` can be run over USB.

`mobile-use` is a Python script with some useful commands:

```
mobile-use [-h] {mirror,unlock,lock} ...

Control my Android phone from this Mac.

positional arguments:
  {mirror,unlock,lock}
    mirror              Unlock and open screen mirroring
    unlock              Wake and unlock the phone
    lock                Turn off the phone screen

options:
  -h, --help            show this help message and exit
```

UPI Lite is available for payments; ask the user for explicit confirmation before hitting
pay.
