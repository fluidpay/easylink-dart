import 'dart:typed_data';

enum Command {
  connect([128, 0]),
  disconnect([128, 1]),
  transactionStart([128, 48]),
  getData([128, 65]),
  setData([128, 64]);

  final List<int> value;
  const Command(this.value);

  Uint8List get data => Uint8List.fromList(value);
}