class Report {
  final String currentStatus;
  final String prompts;
  final String? curSearchMode;
  final String? pinStatus;
  final int? pinLen;

  factory Report.fromJson(Map<String, dynamic> json) {
    final jsonData = json['jsonData'] as Map<String, dynamic>?;
    return Report(
      json['currentStatus'] as String? ?? '',
      json['prompts'] as String? ?? '',
      (jsonData)?['curSearchMode'] as String?,
      (jsonData)?['pinStatus'] as String?,
      (jsonData)?['pinLen'] as int?,
    );
  }

  Report(this.currentStatus, this.prompts, this.curSearchMode, this.pinStatus, this.pinLen);
}
