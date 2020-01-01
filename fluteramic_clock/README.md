# Flutteramic Clock

<img src='analog_clock/analog.gif' width='350'>

Welcome to Flutteramic Clock. A beautiful dynamic background clock face.

Implemented by using custom painter on single canvas for the panoramic background.

This project is created because of the [flutter clock competition](https://flutter.dev/clock)

  **NOTE** : The clock face is optimized for lenovo smart clock display 4" 800 x 480, 5:3 Aspect ratio

## Features:

Dynamic panorama background base on current time base on this 4 session 
   * Sunrise
   * Afternoon
   * Sunset
   * Midnight
  
Element list
   * Aeroplane (daytime)
   * Cloud (daytime)
   * Sea wave
   * Blinking Stars (night time)
   * Lighthouse (night time for light animation)
   * Mountain
   * Moon (night time)
   * Sun (daytime)
   * Small land

## Demo mode

Demo mode can be enable to the clock and background by replacing this line of code at this [file](lib/clock_face.dart)

from:
```
    Panoramic(),
    DateTimeWidget()
```
to:
```
    Panoramic(demoMode: true),
    DateTimeWidget(demoMode: true)
```

## Asset author (Font):
 * Mont: https://www.dafont.com/mont.font
 * Planes: https://www.dafont.com/planes-s-modern.font
 * cloud: DIY

## License:
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).

