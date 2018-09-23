import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_simple_client/app/Constants.dart';
import 'package:flutter_simple_client/core/AsyncResult.dart';
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  NetworkClient(this._client);

  final http.Client _client;

  void getPageOfPhotosAsync(
      int lastPhotoId,
      int photosPerPage,
      Function(List<Photo>) onSuccess,
      Function(Exception) onError
      ) async {

    final result = await getPageOfPhotos(lastPhotoId, photosPerPage);

    if (result.isSuccess()) {
      onSuccess(result.result);
    } else {
      onError(result.error);
    }
  }

  Future<AsyncResult<List<Photo>>> getPageOfPhotos(int lastPhotoId, int photosPerPage) async {
    try {
      final fullUrl = "${Constants.photosUrl}/$lastPhotoId/$photosPerPage";
      debugPrint("trying to make get request to url: $fullUrl");

      final response = await _client
          .get(fullUrl)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception("getPageOfPhotos returned ${response.statusCode} http status!");
      }

      final result = await compute(parsePhotosJson, response.body);
      return AsyncResult.success(result);
    } catch (exception) {
      return AsyncResult.fail(exception);
    }
  }

  static List<Photo> parsePhotosJson(String responseBody) {
    return (json.decode(responseBody) as List)
        .map<Photo>((json) => Photo.fromJson(json)).toList();
  }
}