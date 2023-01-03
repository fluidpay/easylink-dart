class InvalidFrameLength implements Exception {
  String errMsg() => 'invalid payload length detected';
}

class InvalidFrameHeader implements Exception {
  String errMsg() => 'invalid Frame.Header detected';
}

class InvalidFrameData implements Exception {
  String errMsg() => 'invalid Frame.Data detected';
}

class InvalidFrameTail implements Exception {
  String errMsg() => 'invalid Frame.Tail detected';
}

class InvalidLRC implements Exception {
  String errMsg() => 'invalid LRC detected';
}

class ReceiveTimeout implements Exception {
  String errMsg() => 'timeout reached in receive';
}

// region Build Frames

class FrameOrPackSizeException implements Exception {
  String errMsg() => 'FrameSize or PackSize is invalid';
}

class DataLengthException implements Exception {
  String errMsg() => 'Data length is bigger than pack size';
}

// endregion

class DeviceException implements Exception {
  final String actualError;

  DeviceException(this.actualError);

  String errMsg() => 'Device error: $actualError';
}