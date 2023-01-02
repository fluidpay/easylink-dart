This package helps you to use ecr protocol for communication.

## Features

The public Easylink class has the following methods:

- connect()
- disconnect()
- processTransaction()
- completeTransaction()
- setData()
- getData()
- getTransactionResponse()
- getConfiguration()

## Install

To use the package you can import it from the git repository.

```yml
  ecr_protocol:
    git:
      url: git@bitbucket.org:fluidpay/ecr-protocol-dart.git
      ref: v0.1.2
```

For more options check this
page: https://docs.flutter.dev/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages

## Usage

The first step is to create an Easylink object. You have to implement DeviceConnection. Easylink will use this to send
and receive data from your device.

```dart
final deviceConnection = BluetoothDeviceConnection(_simpleblue, connectedDevice);
final sdk = Easylink(deviceConnection);
```

Here is an example for DeviceConnection implementation to communicate with bluetooth device. I use [simpleblue](https://pub.dev/packages/simpleblue) package to handle the connection.
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
Create Simpleblue object
```dart
final _simpleblue = Simpleblue();
```

Before you send commands to you device you have to call:

```dart
sdk.connect();
```

and before you close the connection with your device you have to call:

```dart
sdk.disconnect();
```

To process a transaction create a TransactionData(amount, type, currencyCode, currencyExponent, dateTime) object and
call the processTransaction method.
<br>You can use the onlyTrack2Data parameter to minimize the returning data.

```dart
final transactionData = TransactionData(100000, 0, [1, 1], 0, DateTime.now());

final transactionResponse = await sdk.processTransaction(transactionData, onlyTrack2Data: true);
```

ECR Protocol has a report channel and you can listen to it. Easylink object has a reportCallback property.
```dart
sdk.reportCallback = (report) {
  print(report.prompts);
} 
```