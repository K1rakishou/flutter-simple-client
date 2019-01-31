
import 'package:flutter_simple_client/data/Photo.dart';

abstract class PhotosDataSource {
  Future<List<Photo>> getPageOfPhotos(int lastPhotoId, int count);
}