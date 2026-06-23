Answer:

```bash
sudo modprobe v4l2loopback exclusive_caps=1
```

Note:

Install v4l2loopback-dkms and linux-headers first.

```bash
sudo pacman -S v4l2loopback-dkms
```

```bash
sudo pacman -S linux-headers
```

