import 'dart:async';
import 'dart:convert';

import 'package:easylink/src/ecr/model/exceptions.dart';
import 'package:easylink/src/ecr/model/frame.dart';
import 'package:easylink/src/common/misc.dart';
import 'package:easylink/src/ecr/model/report.dart';
import 'package:easylink/src/ecr/utils.dart';

typedef ReportCallback = Function(Report);

abstract class Connection {
  Future send(List<int> payload);

  Stream<List<int>> receive();
}

class ECR {
  final Connection _connection;
  late StreamSubscription<List<int>> _streamSubscription;
  ReportCallback? reportCallback;

  final _data = <int, Map<int, Frame>>{};

  int _packNo = 1000;
  int _frameSize = 2000;
  int _packSize = 4500;

  final _receivedUnformattedData = <int>[];

  ECR(this._connection) {
    _streamSubscription = _connection.receive().listen((data) async {
      List<Frame> out = [];

      try {
        Frame.from(data, out);
      } catch (e1) {
        if (e1 is! InvalidFrameHeader) {
          print("Ignored ${_receivedUnformattedData.length} bytes: $_receivedUnformattedData");
          _receivedUnformattedData.clear();
          _receivedUnformattedData.addAll(data);
          return;
        }

        try {
          Frame.from([..._receivedUnformattedData, ...data], out);
          _receivedUnformattedData.clear();
        } catch (e2) {
          _receivedUnformattedData.addAll(data);

          print("Couldn't create frame from ${_receivedUnformattedData.length} length received data");

          return;
        }
      }

      for (final frame in out) {
        if (frame.isReport) {
          final reportText = String.fromCharCodes(frame.data);
          final reportJson = jsonDecode(reportText);

          reportCallback?.call(Report.fromJson(reportJson));
        }

        Map<int, Frame> inner = {};
        if (_data.containsKey(frame.packNo)) {
          var inner = _data[frame.packNo]!;
        }
        inner[frame.frameNo] = frame;
        _data[frame.packNo] = inner;

        if (frame.packNo > 100 || frame.packNo == 3) {
          await _sendFrame(Frame.confirm(frame.frameNo, ack));
        }
      }
    });
  }

  // region sync

  Future<List<int>> sendSyncFrame() async {
    final syncResponse = await send(frame: Frame.sync());

    if (syncResponse.length >= 8) {
      _packSize = fromFourByte(syncResponse, 0);
      _frameSize = fromFourByte(syncResponse, 4);
    }

    return syncResponse;
  }

  // endregion

  Future<List<int>> send({List<int>? data, Frame? frame, int timeout = 10000}) async {
    int packageNumber;

    if (frame != null) {
      packageNumber = await _sendFrame(frame);
    } else if (data != null) {
      packageNumber = await _sendData(data);
    } else {
      return [];
    }

    final response = await receive(packageNumber, timeout);

    _parseErrorResponse(response);

    return response;
  }

  Future<List<int>> receive(int packageNumber, [int timeout = 30000]) async {
    int i = 0;
    while (timeout == -1 || i < timeout) {
      if (_data.containsKey(packageNumber)) {
        List<int> result = [];
        var packet = _data[packageNumber]!;
        for (var d in packet.values) {
          result.addAll(d.data);
        }
        _data.remove(packageNumber);

        return result;
      }
      await Future.delayed(Duration(milliseconds: 50));
      i += 50;
    }

    throw ReceiveTimeout();
  }

  Future<int> _sendData(List<int> data) async {
    final packageNumber = _packNo++;
    final frames = buildFrames(packageNumber, data, _packSize, _frameSize);

    for (List<int> frame in frames) {
      await _connection.send(frame);
    }

    return packageNumber;
  }

  Future<int> _sendFrame(Frame frame) async {
    await _connection.send(frame.fullData);

    return frame.packNo;
  }

  _parseErrorResponse(List<int> data) {
    if (data.length >= 70) {
      final possibleError = data.sublist(2, 70);
      final actualError = <int>[];

      for (int value in possibleError) {
        if (value > 31 && value < 126) {
          actualError.add(value);
        }
      }

      if (actualError.isNotEmpty) {
        final errorText = String.fromCharCodes(actualError);
        if (!(errorText.contains('Err:0,') || errorText.contains('Err:-2407,'))) {
          throw DeviceException(errorText);
        }
      }
    }
  }

  Future close() {
    return _streamSubscription.cancel();
  }
}
