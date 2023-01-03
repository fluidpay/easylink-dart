import 'package:easylink/easylink_sdk.dart';

class ExampleDeviceConnection extends Connection {
  @override
  Stream<List<int>> receive() {
    return Stream.value([]);
  }

  @override
  Future send(List<int> payload) async {
    print(payload);
  }
}

void main() async {
  final deviceConnection = ExampleDeviceConnection();
  final sdk = Easylink(deviceConnection);

  sdk.reportCallback = (report) {
    print(report.prompts);
  };

  await sdk.connect();

  final transactionData = TransactionData(10000, 0, [1, 1], 0, DateTime.now());
  final transactionResponse = await sdk.processTransaction(transactionData);

  print(transactionResponse.track2);
}
