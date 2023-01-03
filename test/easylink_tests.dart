import 'package:easylink/easylink_sdk.dart';
import 'package:test/test.dart';

import 'mock/connection_mock.dart';

void main() {
  test('connecting', _testConnecting);
  test('disconnect', _testDisconnecting);
  test('processTransaction', _testProcessTransaction);
  test('processTransactionOnlyTrack2Data', _testProcessTransactionOnlyTrack2Data);
}

void _testConnecting() async {
  final receiveData = [
    [2, 1, 0, 1, 0, 1, 0, 0, 3, 3],
    [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3]
  ];

  final connection = ConnectionMock(receiveData);
  final easylink = Easylink(connection);

  await easylink.connect();

  expect(connection.sentData.length, 3);
  expect(connection.sentData[0], Frame.sync().fullData);
  expect(connection.sentData[1], Frame.confirm(1, ack).fullData);
  expect(connection.sentData[2], [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3]);
}

void _testDisconnecting() {
  final connection = ConnectionMock([]);
  final easylink = Easylink(connection);

  easylink.disconnect();

  expect(connection.sentData.length, 1);
  expect(connection.sentData.first, [2, 1, 3, 232, 0, 1, 0, 2, 128, 1, 106, 3]);
}

void _testProcessTransaction() async {
  final expectedSentData = [
    [
      2,
      1,
      3,
      232,
      0,
      1,
      0,
      37,
      128,
      64,
      1,
      0,
      32,
      159,
      2,
      6,
      0,
      0,
      0,
      16,
      0,
      0,
      156,
      1,
      1,
      95,
      42,
      2,
      1,
      1,
      95,
      54,
      1,
      0,
      154,
      3,
      34,
      6,
      41,
      159,
      33,
      3,
      1,
      17,
      19,
      15,
      3
    ],
    [2, 1, 3, 233, 0, 1, 0, 2, 128, 48, 90, 3],
    [2, 1, 3, 234, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 5, 43, 3],
    [2, 1, 3, 235, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 1, 46, 3],
    [2, 1, 3, 236, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 2, 42, 3],
    [2, 1, 3, 237, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 3, 42, 3],
    [2, 1, 3, 238, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 4, 46, 3],
    [2, 1, 3, 239, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 6, 45, 3],
    [2, 1, 3, 240, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 7, 51, 3],
    [2, 1, 3, 241, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 8, 61, 3],
    [2, 1, 3, 242, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 9, 63, 3],
    [2, 1, 3, 243, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 16, 39, 3],
    [2, 1, 3, 244, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 17, 33, 3],
    [2, 1, 3, 245, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 18, 35, 3],
    [2, 1, 3, 246, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 19, 33, 3],
    [2, 1, 3, 247, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 20, 39, 3],
    [2, 1, 3, 248, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 21, 41, 3],
    [2, 1, 3, 249, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 22, 43, 3],
    [2, 1, 3, 250, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 23, 41, 3],
    [2, 1, 3, 251, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 24, 39, 3],
    [2, 1, 3, 252, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 25, 33, 3],
    [2, 1, 3, 253, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 26, 35, 3],
    [2, 1, 3, 254, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 27, 33, 3],
    [2, 1, 3, 255, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 28, 39, 3],
    [2, 1, 4, 0, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 29, 222, 3],
    [2, 1, 4, 1, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 31, 221, 3]
  ];

  final connection = ConnectionMock(expectedSentData);
  final easylink = Easylink(connection);

  final transactionData = TransactionData(100000, 1, [1, 1], 0, DateTime.now());
  await easylink.processTransaction(transactionData);

  expect(connection.sentDataWithoutSyncFrames.length, 26);
}

void _testProcessTransactionOnlyTrack2Data() async {
  final expectedSentData = [
    [
      2,
      1,
      3,
      232,
      0,
      1,
      0,
      37,
      128,
      64,
      1,
      0,
      32,
      159,
      2,
      6,
      0,
      0,
      0,
      16,
      0,
      0,
      156,
      1,
      1,
      95,
      42,
      2,
      1,
      1,
      95,
      54,
      1,
      0,
      154,
      3,
      34,
      6,
      41,
      159,
      33,
      3,
      1,
      23,
      9,
      19,
      3
    ],
    [2, 1, 3, 233, 0, 1, 0, 2, 128, 48, 90, 3],
    [2, 1, 3, 234, 0, 1, 0, 7, 128, 65, 2, 0, 2, 3, 5, 43, 3]
  ];

  final connection = ConnectionMock(expectedSentData);
  final easylink = Easylink(connection);

  final transactionData = TransactionData(100000, 1, [1, 1], 0, DateTime.now());
  await easylink.processTransaction(transactionData, onlyTrack2Data: true);

  expect(connection.sentDataWithoutSyncFrames.length, 3);
}