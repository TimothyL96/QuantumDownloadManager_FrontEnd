import 'package:QDM_flutter/networking/Response.dart';

class DownloadStatus {
  final Status status;
  final double? percentage;

  DownloadStatus(this.status, this.percentage);

  DownloadStatus.fromJson(Map<String, dynamic> json)
      : status = Status.values[json["status"]],
        percentage = json["percentage"];

  Map<String, dynamic> toJson() => {
        'status': status,
        'percentage': percentage,
      };
}
