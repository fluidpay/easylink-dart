The package implements a high-level communication layer for Easylink capable devices written in Dart specifically for Flutter development.

## Install

To use the package you can import it from the git repository.

```yml
  ecr_protocol:
    git:
      url: git@github.com:fluidpay/easylink-dart.git
      ref: v0.1.0
```

[More information about unpublished package management](https://docs.flutter.dev/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages)

## Usage

### Establish a Bluetooth connection

Anything implements the following abstract class can be a device connection. Note, we only tested it for Bluetooth by using [simpleblue](https://pub.dev/packages/simpleblue). The following snippet defines the requirements of the communication.

```dart
abstract class Connection {
  Future send(List<int> payload);

  Stream<List<int>> receive();
}
```

#### Example Bluetooth connection with Simpleblue library

The following snippet is an example implementation of the abstract class by using [simpleblue](https://pub.dev/packages/simpleblue) library.

```dart
import 'package:ecr_protocol/ecr_protocol.dart';
import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:simpleblue/simpleblue.dart';

class BluetoothDeviceConnection extends Connection {
  final Simpleblue simpleblue;
  final BluetoothDevice connectedDevice;

  BluetoothDeviceConnection(this.simpleblue, this.connectedDevice);

  @override
  Stream<List<int>> receive() {
    return connectedDevice.stream ?? const Stream.empty();
  }

  @override
  Future send(List<int> payload) async {
    return simpleblue.write(connectedDevice.uuid, payload);
  }
}
```

Creating an instance of the `BluetoothDeviceConnection` can be done on this way.

```dart
final _simpleblue = Simpleblue();

// connectedDevice will come from the _simpleblue object, read the manual of the library for further information

final connection = BluetoothDeviceConnection(_simpleblue, connectedDevice);
```

The first step is to create an Easylink object. You have to implement DeviceConnection. Easylink will use this to send
and receive data from your device.

```dart
final _simpleblue = Simpleblue();

// NOTE: connectedDevice will come from the _simpleblue object, read the manual of the library for further information

final connection = BluetoothDeviceConnection(_simpleblue, connectedDevice);
```

The connection will be necessary for the Easylink instance initialization.

### Creation of an Easylink SDK instance

Creating a new instance will return the sdk functionalities what you can use.

```dart
import 'package:ecr_protocol/ecr_protocol.dart';

void main() {
  final sdk = Easylink(connection);
}
```

### Connect/Disconnect via Easylink

Easylink requires us to establish a packet connection. This means something like register the application in the device so it knows that it will send packets in the future. You should disconnect before you closing the application so the device will know that it shouldn't wait more packets from the application

```dart
// Before you are sending commands to you device you have to call
sdk.connect();

// Before you close the connection with your device you have to call
sdk.disconnect();
```

### Process a transaction

Transaction processing requires an instance of TransactionData. You need to pass it to the `sdk.processTransaction`.

```dart
// TransactionData(amount, type, currencyCode, currencyExponent, dateTime)
final transactionData = TransactionData(100000, 0, [1, 1], 0, DateTime.now());

final transactionResponse = await sdk.processTransaction(transactionData, onlyTrack2Data: true);
```

#### Notes

- You can use the onlyTrack2Data additional parameter to minimize the returned dataset.
- We will improve the TransactionData parameter-set in the future. Currently it is very minimal, because it's raw TLV communication under the library.

### Listen for reports

The Easylink devices has a dedicated report channel for messages coming from the device. These mostly happen during transaction processing. You can subscribe for these messages by modifying the corresponding callback function.

```dart
sdk.reportCallback = (report) {
  print(report.prompts);
}
```

### Full example

You can find more examples under the `example` folder.