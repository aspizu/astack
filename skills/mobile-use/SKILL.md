---
name: mobile-use
description: Control my mobile phone using adb.
---

The Pixel's Tailscale ADB address is `$ANDROID_ADB_ADDRESS`. If TCP mode needs
re-enabling, `adb -s "$ANDROID_USB_SERIAL" tcpip 5555` can be run over USB.

The numeric lock-screen PIN is in `ANDROID_PIN`. An unlock sequence is:

```bash
set -e
adb shell input keyevent KEYCODE_WAKEUP
sleep 1.5
if adb shell dumpsys window policy | grep -q 'showing=true'; then
    adb shell input swipe 500 2100 500 700 400
    sleep 1
    adb shell input text "$ANDROID_PIN"
    adb shell input keyevent KEYCODE_ENTER
fi
set +e
```

UPI Lite is available for payments; ask the user for explicit confirmation before hitting
pay.
