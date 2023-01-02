import 'package:ecr_protocol/ecr_protocol.dart';
import 'package:ecr_protocol/src/ecr/utils.dart';
import 'package:test/test.dart';

import 'mock/connection_mock.dart';

void main() {
  test('confirmation only for packNo 3 until packNo 100', _testConfirmationUntilPackNo100);
  test('confirmation all received above packNo 100', _testConfirmationAbove100);
  test('send sync frame', _testSyncFrame);
}

void _testConfirmationUntilPackNo100() async {
  final receiveData = List.generate(101, (index) => buildFrames(index, '{}'.codeUnits, 1000, 200).first);
  final connection = ConnectionMock(receiveData);
  final ecr = ECR(connection);

  await ecr.receive(100);

  expect(connection.sentData.length, 1);
  expect(connection.sentData.first, Frame.confirm(1, ack).fullData);
}

void _testConfirmationAbove100() async {
  final receiveData =
      List.generate(100, (index) => buildFrames(index + 101, '{}'.codeUnits, 1000, 200).first);
  final connection = ConnectionMock(receiveData);
  final ecr = ECR(connection);

  await ecr.receive(200);

  expect(connection.sentData.length, 100);
  for (final sent in connection.sentData) {
    expect(sent, Frame.confirm(1, ack).fullData);
  }
}

void _testSyncFrame() {
  final connection = ConnectionMock([]);
  final ecr = ECR(connection);

  ecr.sendSyncFrame();

  expect(connection.sentData.length, 1);
  expect(connection.sentData.first, [2, 1, 0, 1, 0, 1, 0, 0, 3, 3]);
}
