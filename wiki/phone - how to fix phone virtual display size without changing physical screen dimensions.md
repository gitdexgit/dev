Use the `adb` to set your virtual display size.

Example:

If you want to set it to 500x1040 or
520x1060, you would run:

```sh
adb shell wm size 500x1040
```

And just adjust the whatever comes after the x. --> x1040 --> x1060 and keep adjusting and see what you like until it fits.

```sh
adb shell wm size 500x1060
```

Or from up to down if you want to adjust the screen a bit play with the first number. And that's it

Remember:

```sh
adb shell wm size <{value}x{value}>
```

