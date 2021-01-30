import 'dart:io';

import 'package:flutter_assignment/Models/playArenaModel.dart';
import 'package:flutter_assignment/Repositories/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MainRepository {
  Future<List<PlayArenaModel>> getArenaList() async {
    try {
      var response = await http.get(getArena);
      if (response.statusCode == 200) {
        final _playArenaModel = playArenaModelFromJson(response.body);
        return _playArenaModel;
      } else {
        return null;
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'No internet connection',
        "Unable to reach our servers",
      );
    }
    return null;
  }
}
