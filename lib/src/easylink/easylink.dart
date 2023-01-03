import 'package:easylink/easylink_sdk.dart';
import 'package:easylink/src/easylink/command.dart';
import 'package:easylink/src/easylink/get_data.dart';

class Easylink {
  final ECR _ecr;

  late GetData _dataGetter;

  set reportCallback(ReportCallback? value) {
    _ecr.reportCallback = value;
  }

  Easylink(Connection connection) : _ecr = ECR(connection) {
    _dataGetter = GetData((dataType, config) => _getData(dataType, config));
  }

  Future<bool> connect() async {
    await _ecr.sendSyncFrame();
    await _ecr.send(data: Command.connect.data);

    return true;
  }

  Future<bool> disconnect() async {
    await _ecr.send(data: Command.disconnect.data);

    return true;
  }

  Future close() => _ecr.close();

  Future<TransactionResponse> processTransaction(TransactionData data, {bool onlyTrack2Data = false}) async {
    await _setData(data.toPayload());
    await _ecr.send(data: Command.transactionStart.data, timeout: 60000);

    return _getTransactionResponse(onlyTrack2Data: onlyTrack2Data);
  }

  Future<List<int>> _setData(List<int> req) =>
      _ecr.send(data: [...Command.setData.value, DataType.configuration.value, ...req]);

  Future<List<int>> _getData(DataType dataType, List<int> req) =>
      _ecr.send(data: [...Command.getData.value, dataType.value, ...req]);

  Future<TransactionResponse> _getTransactionResponse({bool onlyTrack2Data = false}) async {
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

    final track2 = await _dataGetter.txTrack2();

    if (!onlyTrack2Data) {
      currentTransactionType = await _dataGetter.txCurrentType();
      currentCLSSType = await _dataGetter.txCurrentCLSSType();
      currentPathType = await _dataGetter.txCurrentPathType();
      track1 = await _dataGetter.txTrack1();
      track3 = await _dataGetter.txTrack3();
      expireDate = await _dataGetter.txExpireDate();
      onlineAuthorizationResult = await _dataGetter.txOnlineAuthorizationResult();
      responseCode = await _dataGetter.txResponseCode();
      authCode = await _dataGetter.txAuthCode();
      authData = await _dataGetter.txAuthData();
      authDataLength = await _dataGetter.txAuthDataLength();
      issuerScript = await _dataGetter.txIssuerScript();
      issuerScriptLength = await _dataGetter.txIssuerScriptLength();
      onlinePinInput = await _dataGetter.txOnlinePINInput();
      pinBlock = await _dataGetter.txPINBlock();
      ksn = await _dataGetter.txKSN();
      ics = await _dataGetter.txICS();
      maskedPAN = await _dataGetter.txMaskedPAN();
      holderVerificationMethod = await _dataGetter.txHolderVerificationMethod();
      cardProcessingResult = await _dataGetter.txCardProcessingResult();
      panData = await _dataGetter.txPANData();
      currencySymbol = await _dataGetter.txCurrencySymbol();
      issuerScriptProcResult = await _dataGetter.txIssuerScriptProcResult();
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
}