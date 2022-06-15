import 'dart:io';

import 'package:projectrio/constants/const.dart';

import 'package:ftpclient/ftpclient.dart';

class FtpService {
  Future <bool> uploadFile(File file, String guid, String ts) async {
    FTPClient client = FTPClient(
      FTP_URL,
      user: FTP_USER,
      pass: FTP_PASS,
      port: FTP_PORT
    );
    try {
      client.connect();
      client.changeDirectory('/kehadiran/image');
      await client.uploadFile(file, sRemoteName: '$guid$ts-PPTIK.jpg');
    } catch(e){
      print('[Upload File] Error $e');
      return false;
    } finally{
      client.disconnect();
    }
    return true;
  }
}