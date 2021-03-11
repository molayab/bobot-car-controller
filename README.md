# BobotMobileController

## Introduction.

Bobot Controller is the mobile controller for the Botot (iot) car. It uses flutter as backbone for both Android and iOS compatibility. It requites BLE IO capabilities reached by `flutter_blue` an external [library](https://pub.dev/packages/flutter_blue).

## Getting Started

In order to compile and run the project, please check the requeriments below. 

### Requeriments

 1. Be sure that dart-lang and flutter are correctly installed on you preferred os. You can find the docummentation [here](https://flutter.dev/docs/get-started/install)

 2. Get the project cloned somewhere in your workspace. `git clone git@github.com:molayab/bobot-car-controller.git` or using the HTTP connection if preferred.

 3. In order to run the project, please run any simulator (iOS on macOS or Android on Win/macOS) or connect your device via USB.

### Building And Running

```bash
# Also works in Win/ PowerShell.
cd <cloned-repo>
# Be sure that flutter is in your $PATH
flutter run
```

## UI Definition 

### BLE Devices List Scene
This scene shows the list of scanned BLE devices, it allows select any of them and begin a try of connection using Bobot's controller protocol, otherwise it shows the error. 

### Bobot Controller Scene
This scene shows a bobot connection info and some debug data helpful for controlling the device. It also contains a single and huge software-based JoyStick that controls the whole device velocity and heading. It contains a admin control menu to shutdown, reset and disconnect the device.

## App Architecture 

### UI 
Flutter Widgets... TBD

### Defined Interfaces 

 1. **Listable**: *Useful interface to enable ListView render capabilities into the model. See Flutter's [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html) for more information.

## Providers 
Dart artifacts that interacts with domain layer. TBD

## Bobot Protocol
### Client Definition

