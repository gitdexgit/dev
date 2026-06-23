
#cli

This is a reflector command that I keep forgetting to run from time to time to get
newest latest good mirrors to improve the speed of updating in `pacman -Suy`  and
also in `paru -Suy` though in paru I recommend you run a VPN to help with github.


```bash
sudo reflector --verbose --latest 10 --number 5 --country Morocco,Spain,Portugal,France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --download-timeout 10
```
