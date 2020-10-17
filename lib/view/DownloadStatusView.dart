import 'package:QDM_flutter/blocs/DownloadStatusBloc.dart';
import 'package:QDM_flutter/models/DownloadStatus.dart';
import 'package:QDM_flutter/networking/Response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetDownloadStatus extends StatefulWidget {
  @override
  _GetDownloadStatusState createState() => _GetDownloadStatusState();
}

class _GetDownloadStatusState extends State<GetDownloadStatus> {
  DownloadStatusBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DownloadStatusBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Download Status',
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        backgroundColor: Color(0xFF333333),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDownloadStatus(),
        child: StreamBuilder<Response<DownloadStatus>>(
          stream: _bloc.downloadStatusStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  break;
                case Status.ERROR:
                  break;
                case Status.COMPLETED:
                  return DownloadStatusText(downloadStatus: snapshot.data.data);
                  break;
              }
            }

            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class DownloadStatusText extends StatelessWidget {
  final DownloadStatus downloadStatus;

  const DownloadStatusText({Key key, this.downloadStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: Text(
        downloadStatus.status.toString() +
            " : " +
            downloadStatus.percentage.toString(),
        style: TextStyle(color: Colors.yellow),
      ),
    );
  }
}
