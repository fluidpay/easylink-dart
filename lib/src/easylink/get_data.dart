import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/ecr/utils.dart';

class GetData {
  final Future<List<int>> Function(DataType dataType, List<int> config) onGetData;

  GetData(this.onGetData);

  // region Transaction

  Future<String> txCurrentType() async {
    final currentType = await _getTransaction(TransactionConfig.currentType);

    switch (currentType[0]) {
      case 0x00:
        return "None";
      case 0x01:
        return "Magnetic Swipe Card";
      case 0x02:
        return "Fallback Swipe Card";
      case 0x03:
        return "EMV Contact Card";
      case 0x04:
        return "Contactless Card";
      case 0x05:
        return "Manual PAN entry";
      default:
        return "Unknown";
    }
  }

  Future<String> txCurrentCLSSType() => _getTransactionString(TransactionConfig.currentCLSSType);

  Future<String> txCurrentPathType() async {
    final pathType = await _getTransaction(TransactionConfig.currentPathType);
    switch (pathType[0]) {
      case 0x00:
        return "CLSS_PATH_NORMAL";
      case 0x01:
        return "CLSS_VISA_MSD";
      case 0x02:
        return "CLSS_VISA_QVSDC";
      case 0x03:
        return "CLSS_VISA_VSDC";
      case 0x04:
        return "CLSS_VISA_CONTACT";
      case 0x05:
        return "CLSS_MC_MAG";
      case 0x06:
        return "CLSS_MC_MCHIP";
      case 0x07:
        return "CLSS_VISA_WAVE2";
      case 0x08:
        return "CLSS_JCB_WAVE2";
      case 0x09:
        return "CLSS_VISA_MSD_CVN17";
      case 0x0A:
        return "CLSS_VISA_MSD_LEGACY";
      default:
        return "Unknown";
    }
  }

  Future<String> txTrack1() => _getTransactionString(TransactionConfig.track1);
  Future<String> txTrack2() => _getTransactionString(TransactionConfig.track2);
  Future<String> txTrack3() => _getTransactionString(TransactionConfig.track3);
  Future<String> txExpireDate() => _getTransactionString(TransactionConfig.expireDate);
  Future<String> txOnlineAuthorizationResult() => _getTransactionString(TransactionConfig.onlineAuthorizationResult);
  Future<String> txResponseCode() => _getTransactionString(TransactionConfig.responseCode);
  Future<String> txAuthCode() => _getTransactionString(TransactionConfig.authCode);
  Future<String> txAuthData() => _getTransactionString(TransactionConfig.authData);
  Future<String> txAuthDataLength() => _getTransactionString(TransactionConfig.authDataLength);
  Future<String> txIssuerScript() => _getTransactionString(TransactionConfig.issuerScript);
  Future<String> txIssuerScriptLength() => _getTransactionString(TransactionConfig.issuerScriptLength);
  Future<String> txOnlinePINInput() => _getTransactionString(TransactionConfig.onlinePINInput);
  Future<String> txPINBlock() => _getTransactionString(TransactionConfig.pinBlock);
  Future<String> txKSN() => _getTransactionString(TransactionConfig.ksn);
  Future<String> txICS() => _getTransactionString(TransactionConfig.ics);
  Future<String> txMaskedPAN() => _getTransactionString(TransactionConfig.maskedPAN);

  Future<String> txHolderVerificationMethod() async {
    final verMethod = await _getTransaction(TransactionConfig.holderVerificationMethod);

    switch (verMethod[0]) {
      case 0x00:
        return "No CVM";
      case 0x01:
        return "Signature";
      case 0x02:
        return "Online PIN";
      case 0x03:
        return "Offline PIN";
      case 0x04:
        return "Reference the customer device";
      default:
        return "Unknown";
    }
  }

  Future<String> txCardProcessingResult() async {
    final processingResult = await _getTransaction(TransactionConfig.cardProcessingResult);

    switch (processingResult[0]) {
      case 0x00:
        return "Declined";
      case 0x01:
        return "Approved";
      case 0x02:
        return "Online request";
      default:
        return "Unknown";
    }
  }

  Future<String> txPANData() => _getTransactionString(TransactionConfig.panData);
  Future<String> txCurrencySymbol() => _getTransactionString(TransactionConfig.currencySymbol);
  Future<String> tx55thField() => _getTransactionString(TransactionConfig.fiftyfifthField);
  Future<String> txIssuerScriptProcResult() => _getTransactionString(TransactionConfig.issuerScriptProcResult);

  // endregion

  // region Configuration

  Future<List<int>> sleepModeTimeout() => _getConfiguration(Param.sleepModeTimeout);
  Future<List<int>> pinEncryptionType() => _getConfiguration(Param.pinEncryptionType);
  Future<List<int>> pinEncryptionKeyIdx() => _getConfiguration(Param.pinEncryptionKeyIdx);
  Future<List<int>> pinBlockMode() => _getConfiguration(Param.pinBlockMode);
  Future<List<int>> dataEncryptionType() => _getConfiguration(Param.dataEncryptionType);
  Future<List<int>> dataEncryptionKeyIdx() => _getConfiguration(Param.dataEncryptionKeyIdx);
  Future<List<int>> fallbackAllowFlag() => _getConfiguration(Param.fallbackAllowFlag);
  Future<List<int>> panMaskStartPos() => _getConfiguration(Param.panMaskStartPos);
  Future<List<int>> transactionProcessingMode() =>  _getConfiguration(Param.transactionProcessingMode);
  Future<List<int>> dukptMode() => _getConfiguration(Param.dukptMode);
  Future<List<int>> macCalculationKeyIndex() => _getConfiguration(Param.macCalculationKeyIndex);
  Future<List<int>> language() => _getConfiguration(Param.language);
  Future<List<int>> macCalculationKeyType() => _getConfiguration(Param.macCalculationKeyType);
  Future<List<int>> macCalculationMode() => _getConfiguration(Param.macCalculationMode);
  Future<List<int>> cardEntryMode() => _getConfiguration(Param.cardEntryMode);
  Future<List<int>> msrRequestPINAuto() => _getConfiguration(Param.msrRequestPINAuto);
  Future<List<int>> supportReport() => _getConfiguration(Param.supportReport);
  Future<List<int>> emvRefundNeedAuthorize() => _getConfiguration(Param.emvRefundNeedAuthorize);
  Future<List<int>> contactlessLightStandard() => _getConfiguration(Param.contactlessLightStandard);
  Future<List<int>> configTags() => _getConfiguration(Param.configTags);
  Future<List<int>> emvTags() => _getConfiguration(Param.emvTags);
  Future<List<int>> notificationCallbackTimeout() => _getConfiguration(Param.notificationCallbackTimeout);
  Future<List<int>> cvmLimitIndicator() => _getConfiguration(Param.cvmLimitIndicator);
  Future<List<int>> cvmLimit() => _getConfiguration(Param.cvmLimit);
  Future<List<int>> paddingRuleKey() => _getConfiguration(Param.paddingRuleKey);
  Future<List<int>> track2SentinelFlag() => _getConfiguration(Param.track2SentinelFlag);
  Future<List<int>> detectCardTimeout() => _getConfiguration(Param.detectCardTimeout);

  // endregion


  Future<String> _getTransactionString(TransactionConfig config) => _getTransaction(config).then((value) => String.fromCharCodes(value));
  Future<List<int>> _getTransaction(TransactionConfig config) => _get(DataType.transaction, config.value);
  Future<List<int>> _getConfiguration(Param config) => _get(DataType.configuration, config.value);

  Future<List<int>> _get(DataType dataType, List<int> config) => onGetData(dataType, payloadForGetSet(config, []));
}
