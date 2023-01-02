import 'dart:typed_data';

enum Command {
  connect([128, 0]),
  disconnect([128, 1]),
  uiShowPage([128, 16]),
  getPinBlock([128, 32]),
  encryptData([128, 33]),
  calculateMac([128, 34]),
  increaseKSN([128, 35]),
  transactionStart([128, 48]),
  transactionComplete([128, 49]),
  getData([128, 65]),
  setData([128, 64]),
  tMSDownloadFile([128, 80]),
  switchCommMode([128, 96]),
  runThirdPartyAppEvent([128, 112]);

  final List<int> value;
  const Command(this.value);

  Uint8List get data => Uint8List.fromList(value);
}