import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/ecr/model/exceptions.dart';
import 'package:easylink/src/ecr/utils.dart';
import 'package:test/test.dart';

void main() {
  test('buildFrames with proper params and receive frame with proper header', _buildFramesParamsOkHeaderOk);
  test('buildFrames with proper params and receive frame with proper data', _buildFramesParamsOkDataOk);
  test('buildFrames with invalid packSize and throws exception', _buildFramesWithInvalidPackSize);
  test('buildFrames with invalid frameSize and throws exception', _buildFramesWithInvalidFrameSize);
  test('buildFrames with bigger length than packageSize and throws exception', _buildFramesWithTooLongData);
  test('buildFrames with long data and return with more frames', _buildFramesLongDataMoreFrames);
}

_buildFramesParamsOkHeaderOk() {
  final packNo = 150;

  final frames = buildFrames(packNo, List.generate(20, (index) => 15), 50, 50);

  expect(frames.length, 1);

  _checkHeader(frames.first, packNo, 1, 20);
}

_buildFramesParamsOkDataOk() {
  final packNo = 150;

  var data = List.generate(20, (index) => 15);
  final frames = buildFrames(packNo, data, 50, 50);

  expect(frames.length, 1);

  final frame = frames.first;

  expect(frame.sublist(8, 8 + data.length), data);
}

_buildFramesWithInvalidPackSize() {
  final data = List.generate(10, (index) => 15);
  final packSize = 0;
  final frameSize = 40;

  expect(() => buildFrames(0, data, packSize, frameSize), throwsA(isA<FrameOrPackSizeException>()));
}

_buildFramesWithInvalidFrameSize() {
  final data = List.generate(10, (index) => 15);
  final packSize = 40;
  final frameSize = 0;

  expect(() => buildFrames(0, data, packSize, frameSize), throwsA(isA<FrameOrPackSizeException>()));
}

_buildFramesWithTooLongData() {
  final data = List.generate(50, (index) => 15);
  final packSize = 40;
  final frameSize = 40;

  expect(() => buildFrames(0, data, packSize, frameSize), throwsA(isA<DataLengthException>()));
}

_buildFramesLongDataMoreFrames() {
  final packNo = 101;
  final data = List.generate(500, (index) => 15);
  final packSize = 1000;
  final frameSize = 200;

  final frames = buildFrames(packNo, data, packSize, frameSize);

  expect(frames.length, 3);

  _checkHeader(frames[0], packNo, 1, 200);
  _checkHeader(frames[1], packNo, 2, 200);
  _checkHeader(frames[2], packNo, 3, 100);
}

_checkHeader(List<int> frame, int packNo, int frameNo, int dataLength) {
  expect(frame[0], stx);
  expect(frame[1], soh);
  expect(frame[2], (packNo >> 8) & 0xFF);
  expect(frame[3], packNo & 0xFF);
  expect(frame[4], (frameNo >> 8) & 0xFF);
  expect(frame[5], frameNo & 0xFF);
  expect(frame[6], (dataLength >> 8) & 0xFF);
  expect(frame[7], dataLength & 0xFF);
}
