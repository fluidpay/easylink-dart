import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/ecr/model/exceptions.dart';
import 'package:test/test.dart';

void main() {
 test('frameFrom with valid payload returns with frame', frameFromValidPayload);
 test('frameFrom with valid payload of multiple frames returns with frames', frameFromValidPayloadWithMultipleFrames);
 test('frameFrom with invalid first byte returns with InvalidFrameHeader exception', frameFromInvalidFirstByte);
 test('frameFrom with invalid second byte returns with InvalidFrameHeader exception', frameFromInvalidSecondByte);
 test('frameFrom with invalid lrc returns with InvalidLRC exception', frameFromInvalidLRC);
 test('frameFrom with invalid last byte returns with InvalidFrameTail exception', frameFromInvalidLastByte);
}

void frameFromValidPayload() {
  final payload = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3];

  final frames = <Frame>[];

  Frame.from(payload, frames);

  expect(frames.length, 1);

  final frame = frames[0];

  expect(frame.header, [2, 1, 3, 232, 0, 1, 0, 2]);
  expect(frame.data, [128, 0]);
  expect(frame.tail, [107, 3]);
  expect(frame.lrc, 107);
  expect(frame.packNo, 1000);
  expect(frame.frameNo, 1);
}

void frameFromValidPayloadWithMultipleFrames() {
  final payload = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3, 2, 1, 3, 233, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 22, 1, 1, 51, 3];

  final frames = <Frame>[];

  Frame.from(payload, frames);

  expect(frames.length, 2);

  var frame = frames[0];

  expect(frame.header, [2, 1, 3, 232, 0, 1, 0, 2]);
  expect(frame.data, [128, 0]);
  expect(frame.tail, [107, 3]);
  expect(frame.lrc, 107);
  expect(frame.packNo, 1000);
  expect(frame.frameNo, 1);

  frame = frames[1];

  expect(frame.header, [2, 1, 3, 233, 0, 1, 0, 9]);
  expect(frame.data, [128, 64, 2, 0, 4, 2, 22, 1, 1]);
  expect(frame.tail, [51, 3]);
  expect(frame.lrc, 51);
  expect(frame.packNo, 1001);
  expect(frame.frameNo, 1);
}

void frameFromInvalidFirstByte() {
 final payload = [1, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3];

 expect(() => Frame.from(payload, []), throwsA(isA<InvalidFrameHeader>()));
}

void frameFromInvalidSecondByte() {
 final payload = [2, 2, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3];

 expect(() => Frame.from(payload, []), throwsA(isA<InvalidFrameHeader>()));
}

void frameFromTooShortDataMultipleFrames2() {
 final payload = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3, 2, 1, 3, 232, 0, 1, 0, 2, 128, 107, 3];

 expect(() => Frame.from(payload, []), throwsA(isA<InvalidFrameData>()));
}

void frameFromInvalidLRC() {
 final payload = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 100, 3];

 expect(() => Frame.from(payload, []), throwsA(isA<InvalidLRC>()));
}

void frameFromInvalidLastByte() {
 final payload = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 9];

 expect(() => Frame.from(payload, []), throwsA(isA<InvalidFrameTail>()));
}