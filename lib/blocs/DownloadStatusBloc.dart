import 'dart:async';

import 'package:QDM_flutter/models/DownloadStatus.dart';
import 'package:QDM_flutter/networking/Response.dart';
import 'package:QDM_flutter/repository/DownloadStatusRepository.dart';
import 'package:flutter/cupertino.dart';

class DownloadStatusBloc {
  late DownloadStatusRepository _downloadStatusRepository;
  late StreamController _downloadStatusController;

  StreamSink<Response<DownloadStatus>> get downloadStatusSink =>
      _downloadStatusController.sink as StreamSink<Response<DownloadStatus>>;

  Stream<Response<DownloadStatus>> get downloadStatusStream =>
      _downloadStatusController.stream as Stream<Response<DownloadStatus>>;

  DownloadStatusBloc() {
    _downloadStatusController = StreamController<Response<DownloadStatus>>();
    _downloadStatusRepository = DownloadStatusRepository();

    fetchDownloadStatus();
  }

  fetchDownloadStatus() async {
    downloadStatusSink.add(Response.loading("Getting download status"));

    try {
      DownloadStatus downloadStatus = await  _downloadStatusRepository.fetchDownloadStatusData();

      downloadStatusSink.add(Response.completed(downloadStatus));
    } catch (e) {
      downloadStatusSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _downloadStatusController.close();
  }
}
