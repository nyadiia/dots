#!/usr/bin/env fish
math -s 1 (cat /sys/class/power_supply/BAT1/voltage_now) x (cat /sys/class/power_supply/BAT1/current_now) / 1000000000000
