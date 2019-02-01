
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/data/datasource/PhotosDataSource.dart';
import 'package:flutter_simple_client/data/datasource/local/AbstractLocalSource.dart';

class PhotosLocalDataSource extends PhotosDataSource with AbstractLocalSource<Photo> {

  @override
  Future<bool> storeEntities(List<Photo> entities) async {
    assert (entities != null);

    // TODO: implement storeEntities
    return true;
  }

  @override
  Future<List<Photo>> getPageOfPhotos(int lastPhotoId, int count) async {
    assert (lastPhotoId != null);
    assert (count != null);

    // TODO: implement getPageOfPhotos
    return null;
  }

  @override
  Future<void> cleanUpOld() async {
    // TODO: implement cleanUpOld
    return null;
  }

}