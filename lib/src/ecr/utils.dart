import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/ecr/model/exceptions.dart';

List<List<int>> buildFrames(int packNo, List<int> data, int packSize, int frameSize) {
  final frames = <List<int>>[];

  if (data.isEmpty) {
    return frames;
  }

  if (packSize <= 0 || frameSize <= 0) {
    throw FrameOrPackSizeException();
  }

  final dataLength = data.length;
  if (dataLength > packSize) {
    throw DataLengthException();
  }

  var frameNo = 0;

  var transmittedDataLength = 0;
  var endOfText = true;

  while (transmittedDataLength < dataLength) {
    frameNo++;
    List<int> frame;

    if (transmittedDataLength + frameSize < dataLength) {
      frame = data.sublist(transmittedDataLength, transmittedDataLength + frameSize).toList();
      transmittedDataLength += frameSize;
      endOfText = false;
    } else {
      frame = data.sublist(transmittedDataLength);
      transmittedDataLength += dataLength - transmittedDataLength;
      endOfText = true;
    }

    frames.add(_buildFrame(packNo, frameNo, frame, endOfText));
  }

  return frames;
}

List<int> _buildFrame(int packNo, int frameNo, List<int> frame, bool endOfText) {
  final payload = <int>[];

  // build header
  payload.addAll([
    stx,
    soh,
    (packNo >> 8) & 0xFF,
    packNo & 0xFF,
    (frameNo >> 8) & 0xFF,
    frameNo & 0xFF,
    (frame.length >> 8) & 0xFF,
    frame.length & 0xFF,
  ]);

  // append frame
  payload.addAll(frame);

  // LRC
  payload.add(calculateLRC(payload, 0, frame.length + 8));

  // last byte
  payload.add(endOfText ? etx : etb);

  return payload;
}

List<int> payloadForGetSet(List<int> param, List<int> data) {
  final payload = <int>[
    ...param,
  ];

  if (data.isNotEmpty) {
    payload.addAll([data.length, ...data]);
  }

  return [0, payload.length, ...payload];
}