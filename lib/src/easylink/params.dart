enum Param {
  sleepModeTimeout([0x02, 0x01]),
  pinEncryptionType([0x02, 0x02]),
  pinEncryptionKeyIdx([0x02, 0x03]),
  pinBlockMode([0x02, 0x04]),
  dataEncryptionType([0x02, 0x05]),
  dataEncryptionKeyIdx([0x02, 0x06]),
  fallbackAllowFlag([0x02, 0x07]),
  panMaskStartPos([0x02, 0x08]),
  transactionProcessingMode([0x02, 0x09]),
  dukptMode([0x02, 0x0a]),
  macCalculationKeyIndex([0x02, 0x10]),
  language([0x02, 0x11]),
  macCalculationKeyType([0x02, 0x12]),
  macCalculationMode([0x02, 0x13]),
  cardEntryMode([0x02, 0x14]),
  msrRequestPINAuto([0x02, 0x15]),
  supportReport([0x02, 0x16]),
  emvRefundNeedAuthorize([0x02, 0x17]),
  contactlessLightStandard([0x02, 0x18]),
  configTags([0x02, 0x19]),
  emvTags([0x02, 0x1a]),
  notificationCallbackTimeout([0x02, 0x1b]),
  cvmLimitIndicator([0x02, 0x1c]),
  cvmLimit([0x02, 0x1d]),
  paddingRuleKey([0x02, 0x1e]),
  track2SentinelFlag([0x02, 0x1f]),
  detectCardTimeout([0x02, 0x20]);

  final List<int> value;

  const Param(this.value);
}

enum DataType {
  configuration(1),
  transaction(2);

  final int value;
  const DataType(this.value);
}

enum ProcessingMode {
  demo([1]),
  normal([0]);

  final List<int> value;

  const ProcessingMode(this.value);
}

enum EntryMode {
  msrSwipe(0x01),
  iccInsert(0x02),
  piccTap(0x04),
  manualPAN(0x10);

  final int value;

  const EntryMode(this.value);
}

enum TransactionConfig {
  currentType([0x03, 0x01]),
  currentCLSSType([0x03, 0x02]),
  currentPathType([0x03, 0x03]),
  track1([0x03, 0x04]),
  track2([0x03, 0x05]),
  track3([0x03, 0x06]),
  expireDate([0x03, 0x07]),
  onlineAuthorizationResult([0x03, 0x08]),
  responseCode([0x03, 0x09]),
  authCode([0x03, 0x10]),
  authData([0x03, 0x11]),
  authDataLength([0x03, 0x12]),
  issuerScript([0x03, 0x13]),
  issuerScriptLength([0x03, 0x14]),
  onlinePINInput([0x03, 0x15]),
  pinBlock([0x03, 0x16]),
  ksn([0x03, 0x17]),
  ics([0x03, 0x18]),
  maskedPAN([0x03, 0x19]),
  holderVerificationMethod([0x03, 0x1a]),
  cardProcessingResult([0x03, 0x1b]),
  panData([0x03, 0x1c]),
  currencySymbol([0x03, 0x1d]),
  fiftyfifthField([0x03, 0x1e]),
  issuerScriptProcResult([0x03, 0x1f]);

  final List<int> value;

  const TransactionConfig(this.value);
}