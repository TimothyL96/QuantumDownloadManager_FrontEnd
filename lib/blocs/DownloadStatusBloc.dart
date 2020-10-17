import 'dart:async';

import 'package:QDM_flutter/models/DownloadStatus.dart';
import 'package:QDM_flutter/networking/Response.dart';
import 'package:QDM_flutter/repository/DownloadStatusRepository.dart';
import 'package:flutter/cupertino.dart';

class DownloadStatusBloc {
  DownloadStatusRepository _downloadStatusRepository;
  StreamController _downloadStatusController;

  StreamSink<Response<DownloadStatus>> get downloadStatusSink =>
      _downloadStatusController.sink;

  Stream<Response<DownloadStatus>> get downloadStatusStream =>
      _downloadStatusController.stream;

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
