import 'package:easylink/easylink_sdk.dart';
import 'package:test/test.dart';

import 'mock/connection_mock.dart';

void main() {
  test("Test SDK receive", _getDataAfterReceive);
}

_getDataAfterReceive() async {
  final receiveData = [
    [2, 1, 0, 1, 0, 1, 0, 0, 3, 3],
    [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3],
    [2, 1, 3, 233, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 22, 1, 1, 51, 3],
    [2, 1, 3, 234, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 9, 1, 1, 47, 3],
    [2, 1, 3, 235, 0, 1, 0, 13, 128, 64, 2, 0, 8, 2, 2, 1, 1, 2, 3, 1, 2, 47, 3],
    [2, 1, 3, 236, 0, 1, 0, 37, 128, 64, 1, 0, 32, 159, 2, 6, 0, 0, 1, 9, 140, 0, 156, 1, 0, 95, 42, 2, 1, 1, 95, 54, 1, 2, 154, 3, 34, 4, 9, 159, 33, 3, 17, 8, 22, 178, 3],
    [2, 1, 3, 237, 0, 1, 0, 7, 128, 65, 2, 0, 2, 2, 22, 62, 3],
    [2, 1, 3, 238, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 22, 1, 1, 51, 3, 2, 1, 3, 239, 0, 1, 0, 2, 128, 48, 93, 3],
  ];

  ECR sdk = ECR(ConnectionMock(receiveData));
  final response = await sdk.receive(1001);
  print(response);
}
