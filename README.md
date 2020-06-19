# App Icon Generator

Automates the generation of Android and iOS app icons from existing SVG vector graphics. 

Creates compact Android Vector XML representations of the adaptive icons for devices running modern Android versions and Mipmap PNG images for older devices. Adaptive icons are available for Android ≥ 8.0, API level 26. 

Creates correctly sized and named PNG images for all iOS devices.

## Icon requirements
The source icons are given as SVG graphics. At least the icon for the Android store should have a square form. The Apple app store also requires a square form without transparency.

The SVG graphics specified as source for the adaptive Android icon must have the correct "inner" dimensions of 72x72dp.

## Prerequesites
1. **Java** Runtime Environment

1. **Inkscape**, version 1.0 or later

1. **Svg2VectorAndroid**

### Installation
1. Install a Java Runtime Environment. The `java` command must be on the `PATH`.
1. Install Inkscape. The `inkscape` command must be on the `PATH`.
1. Download `Svg2VectorAndroid` as a JAR file and store it in the folder of `generate.ps1`.

### Links
Java (OpenJDK): https://openjdk.java.net/

Inkscape: 
https://inkscape.org/

Svg2VectorAndroid:
https://github.com/ravibhojwani86/Svg2VectorAndroid/blob/master/Svg2VectorAndroid-1.0.1.jar

## Current State
Work in Progress:

- The generation of all image files is implemented.
- The icon names in the configuration files must currently be specified manually. Alternatively, you can parameterize the icon names to be what is already configured.

## Contributing
Please support this project by creating issues and pull requests. 

The main goals are:
- Fully automated process, no manual editing of config files.
- Replacement of Svg2VectorAndroid. That application issues library calls to methods of a class from Android Tools. These calls can be issued from a smaller application. For instance, the creation of a temporary folder could be made obsolete. 
- External parameterization support, outside of the script.
  
