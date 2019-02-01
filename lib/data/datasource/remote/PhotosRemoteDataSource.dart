
import 'package:flutter_simple_client/core/MeasureTime.dart';
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/data/PhotoResponse.dart';
import 'package:flutter_simple_client/data/datasource/PhotosDataSource.dart';
import 'package:flutter_simple_client/data/datasource/remote/api/ApiService.dart';

class PhotosRemoteDataSource extends PhotosDataSource {
  final ApiService apiService;

  PhotosRemoteDataSource(this.apiService);

  @override
  Future<List<Photo>> getPageOfPhotos(int lastPhotoId, int count) async {
    assert (lastPhotoId != null);
    assert (count != null);

    final tuple = await measureTime<List<PhotoResponse>>(() {
      return apiService.getPageOfPhotosAsync(lastPhotoId, count);
    });

    final deltaTime = tuple.item2 - Duration(seconds: 1).inMilliseconds;
    final response = tuple.item1;

    if (deltaTime < 0) {
      await Future.delayed(Duration(milliseconds: deltaTime.abs()));
    }

    return response.map((photosResponse) => Photo.fromResponse(photosResponse)).toList();
  }
}