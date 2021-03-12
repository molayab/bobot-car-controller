# BobotMobileController

## Introduction.

Bobot Controller is a mobile controller that controls the Botot (iot) car. It uses flutter as a backbone for both Android and iOS compatibility. It requires BLE IO capabilities of your device. For that project issues `flutter_blue` an external [library](https://pub.dev/packages/flutter_blue).

## Getting Started

To compile and run the project, please check the requirements below. 

### Requeriments

 1. Be sure that dart-lang and flutter are correctly installed on your preferred os. You can find the documentation [here](https://flutter.dev/docs/get-started/install)

 2. Get the project cloned somewhere in your workspace. `git clone git@github.com:molayab/bobot-car-controller.git` or using the HTTP connection if preferred.

 3. To run the project, please run any simulator (iOS on macOS or Android on Win/macOS) or connect your device via USB.

### Building And Running

```bash
# Also works in Win/ PowerShell.
cd <cloned-repo>
# Be sure that flutter is in your $PATH
flutter run
```

## UI Definition 

### BLE Devices List Scene
This scene shows the list of scanned BLE devices. It allows select any of them and begin a try of connection using Bobot's controller protocol, otherwise, it shows the error. 

### Bobot Controller Scene
This scene shows a bobot connection info and some debug data helpful for controlling the device. It also contains a single and huge software-based JoyStick that controls the whole device velocity and heading. It contains an admin control menu to shutdown, reset and disconnect the device.

## App Architecture 

### UI 
Flutter Widgets... TBD

### Defined Interfaces 

 1. **Listable**: *Useful interface to enable ListView to render capabilities into the model. See Flutter's [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html) for more information.*

## Providers 
Dart artifacts that interact with the domain layer. TBD

## Bobot Protocol
### Client Definition

