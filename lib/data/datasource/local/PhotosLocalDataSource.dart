
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/data/datasource/PhotosDataSource.dart';
import 'package:flutter_simple_client/data/datasource/local/AbstractLocalSource.dart';

class PhotosLocalDataSource extends PhotosDataSource with AbstractLocalSource {

  @override
  Future<bool> storeEntities(List entities) {
    assert (entities != null);

    // TODO: implement storeEntities
    return null;
  }

  @override
  Future<List<Photo>> getPageOfPhotos(int lastPhotoId, int count) {
    assert (lastPhotoId != null);
    assert (count != null);

    // TODO: implement getPageOfPhotos
    return null;
  }

  @override
  Future<Function> cleanUpOld() {
    // TODO: implement cleanUpOld
    return null;
  }

}