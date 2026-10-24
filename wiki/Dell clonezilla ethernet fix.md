
If Ethernet is missing and `dmesg` shows `error -3` on `0000:00:19.0`, reset the card as root:

```bash
sudo -i
modprobe -r e1000e
echo 1 > /sys/bus/pci/devices/0000:00:19.0/reset
modprobe e1000e
dhclient -v || dhcpcd
```

Sometimes you might not have `dhclient`. Or simply `dhcpcd` is just a link to idk.
