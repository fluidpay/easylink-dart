import 'package:ecr_protocol/ecr_protocol.dart';
import 'package:ecr_protocol/src/easylink/command.dart';
import 'package:ecr_protocol/src/easylink/get_data.dart';
import 'package:ecr_protocol/src/easylink/model/configuration.dart';
import 'package:ecr_protocol/src/easylink/set_data.dart';

class Easylink {
  final ECR ecr;

  late SetData _dataSetter;
  late GetData _dataGetter;

  SetData get dataSetter => _dataSetter;
  GetData get dataGetter => _dataGetter;

  set reportCallback(ReportCallback? value) {
    ecr.reportCallback = value;
  }

  Easylink(Connection connection) : ecr = ECR(connection) {
    _dataSetter = SetData(this);
    _dataGetter = GetData(this);
  }

  Future<bool> connect() async {
    await ecr.sendSyncFrame();
    await ecr.send(data: Command.connect.data);

    return true;
  }

  Future<bool> disconnect() async {
    await ecr.send(data: Command.disconnect.data);

    return true;
  }

  Future close() => ecr.close();

  Future<TransactionResponse> processTransaction(TransactionData data, {bool onlyTrack2Data = false}) async {
    await setData(data.toPayload());
    await ecr.send(data: Command.transactionStart.data, timeout: 60000);

    return getTransactionResponse(onlyTrack2Data: onlyTrack2Data);
  }

  Future completeTransaction() {
    return ecr.send(data: Command.transactionComplete.data);
  }

  Future<List<int>> setData(List<int> req) =>
      ecr.send(data: [...Command.setData.value, DataType.configuration.value, ...req]);

  Future<List<int>> getData(DataType dataType, List<int> req) =>
      ecr.send(data: [...Command.getData.value, dataType.value, ...req]);

  Future<TransactionResponse> getTransactionResponse({bool onlyTrack2Data = false}) async {
    String currentTransactionType = '';
    String currentCLSSType = '';
    String currentPathType = '';
    String track1 = '';
    String track3 = '';
    String expireDate = '';
    String onlineAuthorizationResult = '';
    String responseCode = '';
    String authCode = '';
    String authData = '';
    String authDataLength = '';
    String issuerScript = '';
    String issuerScriptLength = '';
    String onlinePinInput = '';
    String pinBlock = '';
    String ksn = '';
    String ics = '';
    String maskedPAN = '';
    String holderVerificationMethod = '';
    String cardProcessingResult = '';
    String panData = '';
    String currencySymbol = '';
    String issuerScriptProcResult = '';

    final track2 = await dataGetter.txTrack2();

    if (!onlyTrack2Data) {
      currentTransactionType = await dataGetter.txCurrentType();
      currentCLSSType = await dataGetter.txCurrentCLSSType();
      currentPathType = await dataGetter.txCurrentPathType();
      track1 = await dataGetter.txTrack1();
      track3 = await dataGetter.txTrack3();
      expireDate = await dataGetter.txExpireDate();
      onlineAuthorizationResult = await dataGetter.txOnlineAuthorizationResult();
      responseCode = await dataGetter.txResponseCode();
      authCode = await dataGetter.txAuthCode();
      authData = await dataGetter.txAuthData();
      authDataLength = await dataGetter.txAuthDataLength();
      issuerScript = await dataGetter.txIssuerScript();
      issuerScriptLength = await dataGetter.txIssuerScriptLength();
      onlinePinInput = await dataGetter.txOnlinePINInput();
      pinBlock = await dataGetter.txPINBlock();
      ksn = await dataGetter.txKSN();
      ics = await dataGetter.txICS();
      maskedPAN = await dataGetter.txMaskedPAN();
      holderVerificationMethod = await dataGetter.txHolderVerificationMethod();
      cardProcessingResult = await dataGetter.txCardProcessingResult();
      panData = await dataGetter.txPANData();
      currencySymbol = await dataGetter.txCurrencySymbol();
      issuerScriptProcResult = await dataGetter.txIssuerScriptProcResult();
    }

    return TransactionResponse(
      currentTransactionType,
      currentCLSSType,
      currentPathType,
      track1,
      track2,
      track3,
      expireDate,
      onlineAuthorizationResult,
      responseCode,
      authCode,
      authData,
      authDataLength,
      issuerScript,
      issuerScriptLength,
      onlinePinInput,
      pinBlock,
      ksn,
      ics,
      maskedPAN,
      holderVerificationMethod,
      cardProcessingResult,
      panData,
      currencySymbol,
      issuerScriptProcResult,
    );
  }

  Future<Configuration> getConfiguration() async {
    final sleepModeTimeout = await dataGetter.sleepModeTimeout();
    final pinEncryptionType = await dataGetter.pinEncryptionType();
    final pinEncryptionKeyIdx = await dataGetter.pinEncryptionKeyIdx();
    final pinBlockMode = await dataGetter.pinBlockMode();
    final dataEncryptionType = await dataGetter.dataEncryptionType();
    final dataEncryptionKeyIdx = await dataGetter.dataEncryptionKeyIdx();
    final fallbackAllowFlag = await dataGetter.fallbackAllowFlag();
    final panMaskStartPos = await dataGetter.panMaskStartPos();
    final transactionProcessingMode = await dataGetter.transactionProcessingMode();
    final dukptMode = await dataGetter.dukptMode();
    final macCalculationKeyIndex = await dataGetter.macCalculationKeyIndex();
    final language = await dataGetter.language();
    final macCalculationKeyType = await dataGetter.macCalculationKeyType();
    final macCalculationMode = await dataGetter.macCalculationMode();
    final cardEntryMode = await dataGetter.cardEntryMode();
    final msrRequestPINAuto = await dataGetter.msrRequestPINAuto();
    final supportReport = await dataGetter.supportReport();
    final emvRefundNeedAuthorize = await dataGetter.emvRefundNeedAuthorize();
    final contactlessLightStandard = await dataGetter.contactlessLightStandard();
    final configTags = await dataGetter.configTags();
    final emvTags = await dataGetter.emvTags();
    final notificationCallbackTimeout = await dataGetter.notificationCallbackTimeout();
    final cvmLimitIndicator = await dataGetter.cvmLimitIndicator();
    final cvmLimit = await dataGetter.cvmLimit();
    final paddingRuleKey = await dataGetter.paddingRuleKey();
    final track2SentinelFlag = await dataGetter.track2SentinelFlag();
    final detectCardTimeout = await dataGetter.detectCardTimeout();

    return Configuration(
      sleepModeTimeout: sleepModeTimeout,
      pinEncryptionType: pinEncryptionType,
      pinEncryptionKeyIdx: pinEncryptionKeyIdx,
      pinBlockMode: pinBlockMode,
      dataEncryptionType: dataEncryptionType,
      dataEncryptionKeyIdx: dataEncryptionKeyIdx,
      fallbackAllowFlag: fallbackAllowFlag,
      panMaskStartPos: panMaskStartPos,
      transactionProcessingMode: transactionProcessingMode,
      dukptMode: dukptMode,
      macCalculationKeyIndex: macCalculationKeyIndex,
      language: language,
      macCalculationKeyType: macCalculationKeyType,
      macCalculationMode: macCalculationMode,
      cardEntryMode: cardEntryMode,
      msrRequestPINAuto: msrRequestPINAuto,
      supportReport: supportReport,
      emvRefundNeedAuthorize: emvRefundNeedAuthorize,
      contactlessLightStandard: contactlessLightStandard,
      configTags: configTags,
      emvTags: emvTags,
      notificationCallbackTimeout: notificationCallbackTimeout,
      cvmLimitIndicator: cvmLimitIndicator,
      cvmLimit: cvmLimit,
      paddingRuleKey: paddingRuleKey,
      track2SentinelFlag: track2SentinelFlag,
      detectCardTimeout: detectCardTimeout,
    );
  }
}
