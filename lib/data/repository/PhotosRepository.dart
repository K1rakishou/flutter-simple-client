import 'package:flutter_simple_client/core/Page.dart';
import 'package:flutter_simple_client/data/Photo.dart';
import 'package:flutter_simple_client/data/datasource/local/LocalSourceException.dart';
import 'package:flutter_simple_client/data/datasource/local/PhotosLocalDataSource.dart';
import 'package:flutter_simple_client/data/datasource/remote/PhotosRemoteDataSource.dart';

class PhotosRepository {
  final PhotosRemoteDataSource photosRemoteDataSource;
  final PhotosLocalDataSource photosLocalDataSource;
  final photosPerPage = 20;

  PhotosRepository(this.photosRemoteDataSource, this.photosLocalDataSource);

  Future<Page<Photo>> getPageOfPhotos(
      int lastPhotoId) async {
    assert (lastPhotoId != null);

    //cleanup old cached photos before fetching new
    await photosLocalDataSource.cleanUpOld();

    //check whether we have enough data in the cache
    final cachedPhotos =
        await photosLocalDataSource.getPageOfPhotos(lastPhotoId, photosPerPage);
    if (cachedPhotos != null && cachedPhotos.length == photosPerPage) {
      //if we have - return cached data
      return new Page(cachedPhotos, false);
    }

    //otherwise fetch fresh data
    final freshPhotos =
        await photosRemoteDataSource.getPageOfPhotos(lastPhotoId, photosPerPage);

    if (freshPhotos == null || freshPhotos.isEmpty) {
      return Page.end();
    }

    //cache it
    final storeResult = await photosLocalDataSource.storeEntities(freshPhotos);
    if (!storeResult) {
      throw LocalSourceException();
    }

    //and return it
    return Page(freshPhotos, freshPhotos.length == photosPerPage);
  }
}
