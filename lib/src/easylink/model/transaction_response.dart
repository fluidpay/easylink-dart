class TransactionResponse {
  final String currentTransactionType;
  final String currentCLSSType;
  final String currentPathType;
  final String track1;
  final String track2;
  final String track3;
  final String expireDate;
  final String onlineAuthorizationResult;
  final String responseCode;
  final String authCode;
  final String authData;
  final String authDataLength;
  final String issuerScript;
  final String issuerScriptLength;
  final String onlinePinInput;
  final String pinBlock;
  final String ksn;
  final String ics;
  final String maskedPAN;
  final String holderVerificationMethod;
  final String cardProcessingResult;
  final String panData;
  final String currencySymbol;
  final String issuerScriptProcResult;

  TransactionResponse(
      this.currentTransactionType,
      this.currentCLSSType,
      this.currentPathType,
      this.track1,
      this.track2,
      this.track3,
      this.expireDate,
      this.onlineAuthorizationResult,
      this.responseCode,
      this.authCode,
      this.authData,
      this.authDataLength,
      this.issuerScript,
      this.issuerScriptLength,
      this.onlinePinInput,
      this.pinBlock,
      this.ksn,
      this.ics,
      this.maskedPAN,
      this.holderVerificationMethod,
      this.cardProcessingResult,
      this.panData,
      this.currencySymbol,
      this.issuerScriptProcResult);
}
