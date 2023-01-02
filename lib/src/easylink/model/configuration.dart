class Configuration {
  final List<int> sleepModeTimeout;
  final List<int> pinEncryptionType;
  final List<int> pinEncryptionKeyIdx;
  final List<int> pinBlockMode;
  final List<int> dataEncryptionType;
  final List<int> dataEncryptionKeyIdx;
  final List<int> fallbackAllowFlag;
  final List<int> panMaskStartPos;
  final List<int> transactionProcessingMode;
  final List<int> dukptMode;
  final List<int> macCalculationKeyIndex;
  final List<int> language;
  final List<int> macCalculationKeyType;
  final List<int> macCalculationMode;
  final List<int> cardEntryMode;
  final List<int> msrRequestPINAuto;
  final List<int> supportReport;
  final List<int> emvRefundNeedAuthorize;
  final List<int> contactlessLightStandard;
  final List<int> configTags;
  final List<int> emvTags;
  final List<int> notificationCallbackTimeout;
  final List<int> cvmLimitIndicator;
  final List<int> cvmLimit;
  final List<int> paddingRuleKey;
  final List<int> track2SentinelFlag;
  final List<int> detectCardTimeout;

  Configuration(
      {this.sleepModeTimeout = const [],
        this.pinEncryptionType = const [],
        this.pinEncryptionKeyIdx = const [],
        this.pinBlockMode = const [],
        this.dataEncryptionType = const [],
        this.dataEncryptionKeyIdx = const [],
        this.fallbackAllowFlag = const [],
        this.panMaskStartPos = const [],
        this.transactionProcessingMode = const [],
        this.dukptMode = const [],
        this.macCalculationKeyIndex = const [],
        this.language = const [],
        this.macCalculationKeyType = const [],
        this.macCalculationMode = const [],
        this.cardEntryMode = const [],
        this.msrRequestPINAuto = const [],
        this.supportReport = const [],
        this.emvRefundNeedAuthorize = const [],
        this.contactlessLightStandard = const [],
        this.configTags = const [],
        this.emvTags = const [],
        this.notificationCallbackTimeout = const [],
        this.cvmLimitIndicator = const [],
        this.cvmLimit = const [],
        this.paddingRuleKey = const [],
        this.track2SentinelFlag = const [],
        this.detectCardTimeout = const []});
}
