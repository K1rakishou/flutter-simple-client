import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_simple_client/Constants.dart';
import 'package:flutter_simple_client/data/PhotoResponse.dart';
import 'package:flutter_simple_client/data/datasource/remote/api/BadHttpStatusCodeException.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client;
  final webRequestTimeoutSeconds = Duration(seconds: 10);
  final httpStatusCodeOk = 200;

  ApiService(this._client);

  Future<List<PhotoResponse>> getPageOfPhotosAsync(
      int lastPhotoId, int count) async {
    final fullUrl = "${Constants.photosUrl}/$lastPhotoId/$count";

    final response =
        await _client.get(fullUrl).timeout(webRequestTimeoutSeconds);

    if (response.statusCode != httpStatusCodeOk) {
      throw BadHttpStatusCodeException("Status code is not 200 (${response.statusCode})");
    }

    return await compute(parsePhotosJson, response.body);
  }

  static List<PhotoResponse> parsePhotosJson(String responseBody) {
    return (json.decode(responseBody) as List)
        .map<PhotoResponse>((json) => PhotoResponse.fromJson(json))
        .toList();
  }
}
