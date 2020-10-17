import 'package:QDM_flutter/models/DownloadStatus.dart';
import 'package:QDM_flutter/networking/ApiProvider.dart';

class DownloadStatusRepository {
  ApiProvider _provider = ApiProvider();

  Future<DownloadStatus> fetchDownloadStatusData() async {
    final response = await _provider.get("status");
    print('completed!!!!!!!!@!@@!@@@@  ' +  response.toString());
    return DownloadStatus.fromJson(response);
  }
}