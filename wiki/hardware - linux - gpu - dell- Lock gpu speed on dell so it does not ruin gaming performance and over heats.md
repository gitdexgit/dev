That is the best way to build muscle memory.

Here is your exact two-line manual cheat sheet whenever you boot up and want to game cold:

```bash
# 1. Lock CPU to 2.0 GHz
sudo cpupower frequency-set -u 2000MHz

# 2. Lock GPU to 650 MHz (base + boost)
echo 650 | sudo tee /sys/class/drm/card0/gt_max_freq_mhz /sys/class/drm/card0/gt_boost_freq_mhz
```

Once those two lines are burned into memory, you can automate them later whenever you want.
