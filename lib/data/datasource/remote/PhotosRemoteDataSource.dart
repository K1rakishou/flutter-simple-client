
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/data/datasource/PhotosDataSource.dart';
import 'package:flutter_simple_client/data/datasource/remote/api/ApiService.dart';

class PhotosRemoteDataSource extends PhotosDataSource {
  final ApiService apiService;

  PhotosRemoteDataSource(this.apiService);

  @override
  Future<List<Photo>> getPageOfPhotos(int lastPhotoId, int count) async {
    assert (lastPhotoId != null);
    assert (count != null);

    final response = await apiService.getPageOfPhotosAsync(lastPhotoId, count);
    return response.map((photosResponse) => Photo.fromResponse(photosResponse));
  }
}