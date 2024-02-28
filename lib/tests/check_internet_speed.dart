import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/speed_test_dart.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class CheckInternetSpeed extends StatefulWidget {
  const CheckInternetSpeed({super.key});

  @override
  State<CheckInternetSpeed> createState() => _CheckInternetSpeedState();
}

class _CheckInternetSpeedState extends State<CheckInternetSpeed> {
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  double downloadRate = 0;
  double uploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  Future<void> setBestServers() async {
    final settings = await tester.getSettings();
    final servers = settings.servers;

    final _bestServersList = await tester.getBestServers(
      servers: servers,
    );

    setState(() {
      bestServersList = _bestServersList;
      readyToTest = true;
    });
  }

  Future<void> _testDownloadSpeed() async {
    setState(() {
      loadingDownload = true;
    });
    final _downloadRate =
        await tester.testDownloadSpeed(servers: bestServersList);
    setState(() {
      downloadRate = _downloadRate;
      loadingDownload = false;
    });
  }

  Future<void> _testUploadSpeed() async {
    setState(() {
      loadingUpload = true;
    });

    final _uploadRate = await tester.testUploadSpeed(servers: bestServersList);

    setState(() {
      uploadRate = _uploadRate;
      loadingUpload = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setBestServers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(title: "checking internet"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Download Test:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (loadingDownload)
              Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Testing download speed...'),
                ],
              )
            else
              Text('Download rate  ${downloadRate.toStringAsFixed(2)} Mb/s'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    readyToTest && !loadingDownload ? Colors.blue : Colors.grey,
              ),
              onPressed: loadingDownload
                  ? null
                  : () async {
                      if (!readyToTest || bestServersList.isEmpty) return;
                      await _testDownloadSpeed();
                    },
              child: const Text('Start'),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Upload Test:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (loadingUpload)
              Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Testing upload speed...'),
                ],
              )
            else
              Text('Upload rate ${uploadRate.toStringAsFixed(2)} Mb/s'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: readyToTest ? Colors.blue : Colors.grey,
              ),
              onPressed: loadingUpload
                  ? null
                  : () async {
                      if (!readyToTest || bestServersList.isEmpty) return;
                      await _testUploadSpeed();
                    },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
