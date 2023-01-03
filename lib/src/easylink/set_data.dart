import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/ecr/utils.dart';

class SetData {
  final Future<List<int>> Function(List<int> payload) onSetData;

  SetData(this.onSetData);

  // region Configuration

  Future<List<int>> sleepModeTimeout(List<int> data) => _setConfiguration(Param.sleepModeTimeout, data);
  Future<List<int>> pinEncryptionType(List<int> data) => _setConfiguration(Param.pinEncryptionType, data);
  Future<List<int>> pinBlockMode(List<int> data) => _setConfiguration(Param.pinBlockMode, data);
  Future<List<int>> dataEncryptionType(List<int> data) => _setConfiguration(Param.dataEncryptionType, data);
  Future<List<int>> dataEncryptionKeyIdx(List<int> data) =>
      _setConfiguration(Param.dataEncryptionKeyIdx, data);

  Future<List<int>> fallbackAllowFlag(List<int> data) => _setConfiguration(Param.fallbackAllowFlag, data);
  Future<List<int>> panMaskStartPos(List<int> data) => _setConfiguration(Param.panMaskStartPos, data);
  Future<List<int>> transactionProcessingMode(List<int> data) =>
      _setConfiguration(Param.transactionProcessingMode, data);

  Future<List<int>> dukptMode(List<int> data) => _setConfiguration(Param.dukptMode, data);
  Future<List<int>> macCalculationKeyIndex(List<int> data) =>
      _setConfiguration(Param.macCalculationKeyIndex, data);

  Future<List<int>> language(List<int> data) => _setConfiguration(Param.language, data);
  Future<List<int>> macCalculationKeyType(List<int> data) =>
      _setConfiguration(Param.macCalculationKeyType, data);

  Future<List<int>> cardEntryMode(List<int> data) => _setConfiguration(Param.cardEntryMode, data);
  Future<List<int>> msrRequestPINAuto(List<int> data) => _setConfiguration(Param.msrRequestPINAuto, data);
  Future<List<int>> supportReport(List<int> data) => _setConfiguration(Param.supportReport, data);
  Future<List<int>> emvRefundNeedAuthorize(List<int> data) =>
      _setConfiguration(Param.emvRefundNeedAuthorize, data);

  Future<List<int>> contactlessLightStandard(List<int> data) =>
      _setConfiguration(Param.contactlessLightStandard, data);

  Future<List<int>> configTags(List<int> data) => _setConfiguration(Param.configTags, data);
  Future<List<int>> emvTags(List<int> data) => _setConfiguration(Param.emvTags, data);
  Future<List<int>> notificationCallbackTimeout(List<int> data) =>
      _setConfiguration(Param.notificationCallbackTimeout, data);

  Future<List<int>> cvmLimitIndicator(List<int> data) => _setConfiguration(Param.cvmLimitIndicator, data);
  Future<List<int>> cvmLimit(List<int> data) => _setConfiguration(Param.cvmLimit, data);
  Future<List<int>> paddingRuleKey(List<int> data) => _setConfiguration(Param.paddingRuleKey, data);
  Future<List<int>> track2SentinelFlag(List<int> data) => _setConfiguration(Param.track2SentinelFlag, data);
  Future<List<int>> detectCardTimeout(List<int> data) => _setConfiguration(Param.detectCardTimeout, data);
  Future<List<int>> currentType(List<int> data) => _setTransaction(TransactionConfig.currentType, data);
  Future<List<int>> onlineAuthorizationResult(List<int> data) =>
      _setTransaction(TransactionConfig.onlineAuthorizationResult, data);

  // endregion

  // region Transaction

  Future<List<int>> responseCode(List<int> data) => _setTransaction(TransactionConfig.responseCode, data);
  Future<List<int>> authCode(List<int> data) => _setTransaction(TransactionConfig.authCode, data);
  Future<List<int>> authData(List<int> data) => _setTransaction(TransactionConfig.authData, data);
  Future<List<int>> authDataLength(List<int> data) => _setTransaction(TransactionConfig.authDataLength, data);
  Future<List<int>> issuerScript(List<int> data) => _setTransaction(TransactionConfig.issuerScript, data);
  Future<List<int>> issuerScriptLength(List<int> data) =>
      _setTransaction(TransactionConfig.issuerScriptLength, data);

  Future<List<int>> onlinePINInput(List<int> data) => _setTransaction(TransactionConfig.onlinePINInput, data);
  Future<List<int>> pinBlock(List<int> data) => _setTransaction(TransactionConfig.pinBlock, data);
  Future<List<int>> ksn(List<int> data) => _setTransaction(TransactionConfig.ksn, data);
  Future<List<int>> ics(List<int> data) => _setTransaction(TransactionConfig.ics, data);
  Future<List<int>> currencySymbol(List<int> data) => _setTransaction(TransactionConfig.currencySymbol, data);
  Future<List<int>> fiftyfifthField(List<int> data) =>
      _setTransaction(TransactionConfig.fiftyfifthField, data);

  // endregion


  Future<List<int>> _setTransaction(TransactionConfig config, List<int> data) => _set(config.value, data);
  Future<List<int>> _setConfiguration(Param param, List<int> data) => _set(param.value, data);
  Future<List<int>> _set(List<int> param, List<int> data) => onSetData(payloadForGetSet(param, data));
}
