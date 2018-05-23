(Scribbled version of C:\Users\timi\AppData\Local\Temp\ink_ext_XXXXXX.svgYLM3HZ @ 3500.00)
( unicorn.py --tab="plotter_setup" --pen-up-angle=50 --pen-down-angle=30 --start-delay=150 --stop-delay=150 --xy-feedrate=3500 --z-feedrate=150 --z-height=0 --finished-height=0 --register-pen=true --x-home=0 --y-home=0 --num-copies=1 --continuous=false --pause-on-layer-change=false C:\Users\timi\AppData\Local\Temp\ink_ext_XXXXXX.svgYLM3HZ )
G21 (metric ftw)
G90 (absolute mode)
G92 X0.00 Y0.00 Z0.00 (you are here)

M300 S30 (pen down)
G4 P150 (wait 150ms)
M300 S50 (pen up)
G4 P150 (wait 150ms)
M18 (disengage drives)
M01 (Was registration test successful?)
M17 (engage drives if YES, and continue)

(Polyline consisting of 1 segments.)
G1 X36.58 Y36.58 F3500.00
M300 S30.00 (pen down)
G4 P150 (wait 150ms)
G1 X34.00 Y32.27 F3500.00
G1 X32.64 Y30.16 F3500.00
G1 X30.88 Y28.24 F3500.00
G1 X28.48 Y26.66 F3500.00
G1 X25.17 Y25.55 F3500.00
G1 X20.72 Y25.03 F3500.00
G1 X14.85 Y25.25 F3500.00
G1 X2.94 Y3.13 F3500.00
G1 X7.47 Y3.64 F3500.00
G1 X11.56 Y4.43 F3500.00
G1 X15.25 Y5.49 F3500.00
G1 X18.55 Y6.80 F3500.00
G1 X21.48 Y8.35 F3500.00
G1 X24.08 Y10.11 F3500.00
G1 X26.36 Y12.09 F3500.00
G1 X28.35 Y14.25 F3500.00
G1 X30.07 Y16.59 F3500.00
G1 X31.55 Y19.09 F3500.00
G1 X33.86 Y24.51 F3500.00
G1 X35.48 Y30.38 F3500.00
G1 X36.58 Y36.58 F3500.00
M300 S50.00 (pen up)
G4 P150 (wait 150ms)

(Polyline consisting of 1 segments.)
G1 X8.80 Y19.00 F3500.00
M300 S30.00 (pen down)
G4 P150 (wait 150ms)
G1 X31.10 Y1.24 F3500.00
G1 X8.80 Y19.00 F3500.00
M300 S50.00 (pen up)
G4 P150 (wait 150ms)


(end of print job)
M300 S50.00 (pen up)
G4 P150 (wait 150ms)
M300 S255 (turn off servo)
G1 X0 Y0 F3500.00
G1 Z0.00 F150.00 (go up to finished level)
G1 X0.00 Y0.00 F3500.00 (go home)
M18 (drives off)
