const stx = 2;
const etx = 3;
const soh = 1;
const etb = 23;
const ack = 6;
const nak = 21;

int fromTwoByte(List<int> header, int index) {
  return ((header[index] << 8) & 65280) | (header[index + 1] & 255);
}

int fromFourByte(List<int> data, int index) {
  var byte1 = 4278190080 & (data[index] << 24);
  var byte2 = 16711680 & (data[index + 1] << 16);
  var byte3 = 65280 & (data[index + 2] << 8);
  var byte4 = 255 & data[index + 3];
  return byte1 | byte2 | byte3 | byte4;
}

int fromNByte(List<int> data) {
  int result = 0;
  for (var i = data.length; i >= 0; i--) {
    var index = data.length - i - 1;
    var left = 255 << (8 * i);
    var right = data[index] << (8 * i);
    result |= left & right;
  }
  return result;
}

int calculateLRC(List<int> data, int startFrom, int length) {
  int lrc = 0;

  for (var i = 0; i < length; i++) {
    lrc ^= data[i + startFrom];
  }

  return lrc;
}

List<int> stringToBCD(String s) {
  List<int> bcd = [];
  var length = s.length;

  if (length <= 0) {
    return bcd;
  }

  if (length % 2 != 0) {
    s = "0" + s;
    length = s.length;
  }

  if (length >= 2) {
    length = length ~/ 2;
  }

  List<int> bytes = s.codeUnits;

  for (var i = 0; i < bytes.length / 2; i++) {
    int index = 2 * i;
    int first = byteToInt(bytes[index]) << 4;
    int second = byteToInt(bytes[index + 1]);
    bcd.add(first + second);
  }

  return bcd;
}

int byteToInt(int b) {
  if (b >= 96 && b <= 122) {
    return b - 96 + 0x0A;
  } else if (b >= 65 && b <= 90) {
    return b - 65 + 0x0A;
  } else {
    return b - 48;
  }
}
