#!/bin/sh
# Set the desired environment variable
export QT_QPA_PLATFORMTHEME=kde
# Execute the dolphin file manager, passing all arguments
exec dolphin "$@"
