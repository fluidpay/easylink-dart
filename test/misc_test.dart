import 'package:easylink/easylink_sdk.dart';
import 'package:test/test.dart';

void main() {
  test("Test calculate LRC", _calculateLRC);
  test("Test string to BCD", _stringToBCD);
}

_stringToBCD() async {
  String input = "102300";
  List<int> output = stringToBCD(input);
  List<int> expected = [0x10, 0x23, 0x00];
  expect(output, expected);

  input = "1102300";
  output = stringToBCD(input);
  expected = [0x01, 0x10, 0x23, 0x00];
  expect(output, expected);

  input = "3990800";
  output = stringToBCD(input);
  expected = [0x03, 0x99, 0x08, 0x00];
  expect(output, expected);

  input = "99097700";
  output = stringToBCD(input);
  expected = [0x99, 0x09, 0x77, 0x00];
  expect(output, expected);

  input = "9999999";
  output = stringToBCD(input);
  expected = [0x09, 0x99, 0x99, 0x99];
  expect(output, expected);
}

_calculateLRC() async {
  List<int> input = [2, 1, 0, 1, 0, 1, 0, 0, 0, 0];
  int output = calculateLRC(input, 0, input.length-2);
  expect(output, 3);

  input = [2, 1, 3, 232, 0, 1, 0, 2, 128, 0, 107, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 107);

  input = [2, 1, 0, 0, 0, 1, 0, 1, 6, 5, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 5);

  input = [2, 1, 3, 233, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 22, 1, 1, 51, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 51);

  input = [2, 1, 3, 234, 0, 1, 0, 9, 128, 64, 2, 0, 4, 2, 9, 1, 1, 47, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 47);

  input = [2, 1, 3, 235, 0, 1, 0, 13, 128, 64, 2, 0, 8, 2, 2, 1, 1, 2, 3, 1, 2, 47, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 47);

  input = [2, 1, 3, 236, 0, 1, 0, 37, 128, 64, 1, 0, 32, 159, 2, 6, 0, 0, 1, 9, 140, 0, 156, 1, 0, 95, 42, 2, 1, 1, 95, 54, 1, 2, 154, 3, 34, 4, 9, 159, 33, 3, 17, 8, 22, 178, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 178);

  input = [2, 1, 3, 237, 0, 1, 0, 7, 128, 65, 2, 0, 2, 2, 22, 62, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 62);

  input = [2, 1, 3, 238, 0, 1, 0, 2, 128, 48, 93, 3];
  output = calculateLRC(input, 0, input.length-2);
  expect(output, 93);
}