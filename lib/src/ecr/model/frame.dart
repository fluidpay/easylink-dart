import 'package:ecr_protocol/ecr_protocol.dart';

import 'package:ecr_protocol/src/common/misc.dart' as misc;
import 'exceptions.dart' as exceptions;

class Frame {
  late List<int> header;
  late List<int> data;
  late List<int> tail;

  Frame();

  factory Frame.sync() {
    final frame = Frame()
      ..header = [
        stx,
        soh,
        0,
        1,
        0,
        1,
        0,
        0,
      ]
      ..data = []
      ..tail = [0, etx];

    frame.lrc = calculateLRC(frame.fullData, 0, frame.fullData.length - 2);

    return frame;
  }

  factory Frame.confirm(int frameNo, int confirmCode) {
    final frame = Frame()
      ..header = [
        stx,
        soh,
        0,
        0,
        (frameNo >> 8) & 0xFF,
        (frameNo >> 0) & 0xFF,
        0,
        1,
      ]
      ..data = [confirmCode]
      ..tail = [0, etx];

    frame.lrc = calculateLRC(frame.fullData, 0, frame.fullData.length - 2);

    return frame;
  }

  List<int> get fullData => [...header, ...data, ...tail];

  int get frameNo {
    return misc.fromTwoByte(header, 4);
  }

  int get packNo {
    return misc.fromTwoByte(header, 2);
  }

  int get dataLength {
    return misc.fromTwoByte(header, 6);
  }

  int get lrc {
    return tail.first;
  }

  bool get isSync => packNo == 1;

  bool get isReport => packNo == 3;

  set lrc(int value) {
    tail[0] = value;
  }


  @override
  String toString() {
    if (isReport) {
      return "Report: $data";
    }

    return super.toString();
  }


  static void from(List<int> raw, List<Frame> outputFrames) {
    while (true) {
      if (raw.isEmpty) {
        break;
      }
      if (raw.length <= 7) {
        throw exceptions.InvalidFrameLength();
      }

      Frame f = Frame();

      // Header
      var header = raw.getRange(0, 8);
      f.header = header.toList();
      if (f.header[0] != misc.stx || f.header[1] != misc.soh) {
        throw exceptions.InvalidFrameHeader();
      }
      var lrc = misc.calculateLRC(f.header, 0, 8);

      // Data
      int encodedLength = f.dataLength;
      f.data = [];
      final dataEndIndex = encodedLength + 8;

      if (dataEndIndex + 2 > raw.length) {
        throw exceptions.InvalidFrameData();
      }

      if (encodedLength > 0) {
        var data = raw.getRange(8, dataEndIndex);
        f.data = data.toList();
      }
      if (encodedLength != f.data.length) {
        throw exceptions.InvalidFrameData();
      }
      lrc ^= misc.calculateLRC(f.data, 0, encodedLength);

      // Tail
      var tail = raw.getRange(dataEndIndex, encodedLength + 10);
      f.tail = tail.toList();
      if (f.tail.length != 2) {
        throw exceptions.InvalidFrameTail();
      }
      if (f.lrc != lrc) {
        throw exceptions.InvalidLRC();
      }
      if (f.tail[1] != misc.etx && f.tail[1] != misc.etb) {
        throw exceptions.InvalidFrameTail();
      }
      raw = raw.getRange(encodedLength + 10, raw.length).toList();

      outputFrames.add(f);
    }
  }
}