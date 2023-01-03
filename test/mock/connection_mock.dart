import 'package:easylink/src/ecr/ecr.dart';

class ConnectionMock extends Connection {
  final List<List<int>> receiveData;

  final _sentData = <List<int>>[];

  List<List<int>> get sentData => _sentData;
  List<List<int>> get sentDataWithoutSyncFrames => _sentData.where((data) => data.length != 11).toList();

  ConnectionMock(this.receiveData);

  @override
  Stream<List<int>> receive() async* {
    for (final data in receiveData) {
      yield data;
    }
  }

  @override
  Future send(List<int> payload) async {
    _sentData.add(payload);
  }
}