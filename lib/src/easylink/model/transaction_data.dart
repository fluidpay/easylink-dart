import 'package:ecr_protocol/src/common/misc.dart';

class TransactionData {
  final int amount;
  final int type;
  final List<int> currencyCode;
  final int currencyExponent;
  final DateTime dateTime;

  TransactionData(this.amount, this.type, this.currencyCode, this.currencyExponent, this.dateTime);

  List<int> _parseAmount() {
    var amountString = amount.toString();

    for (int i = amountString.length; i < 12; ++i) {
      amountString = '0$amountString';
    }

    return stringToBCD(amountString);
  }

  List<int> _parseDate() {
    return [
      int.parse((dateTime.year % 100).toString(), radix: 16),
      int.parse(dateTime.month.toString(), radix: 16),
      int.parse(dateTime.day.toString(), radix: 16),
    ];
  }

  List<int> _parseTime() {
    return [
      int.parse(dateTime.hour.toString(), radix: 16),
      int.parse(dateTime.minute.toString(), radix: 16),
      int.parse(dateTime.second.toString(), radix: 16),
    ];
  }

  List<int> toPayload() {
    final fieldNameAmount = [0x9f, 0x02];
    final fieldNameType = [0x9c];
    final fieldNameCurrencyCode = [0x5f, 0x2a];
    final fieldNameCurrencyExponent = [0x5f, 0x36];
    final fieldNameDate = [0x9a];
    final fieldNameTime = [0x9f, 0x21];

    final fields = <int>[
      // Amount
      ...fieldNameAmount,
      0x06,
      ..._parseAmount(),

      // Type
      ...fieldNameType,
      0x01,
      type,

      // CurrencyCode
      ...fieldNameCurrencyCode,
      currencyCode.length,
      ...currencyCode,

      // CurrencyExponent
      ...fieldNameCurrencyExponent,
      0x01,
      currencyExponent,

      // Date
      ...fieldNameDate,
      0x03,
      ..._parseDate(),

      // Time
      ...fieldNameTime,
      0x03,
      ..._parseTime(),
    ];

    return [0, fields.length, ...fields];
  }
}
