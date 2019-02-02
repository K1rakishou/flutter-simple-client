import 'package:bloc/bloc.dart';
import 'package:flutter_simple_client/data/repository/PhotosRepository.dart';
import 'package:flutter_simple_client/features/PhotosEvent.dart';
import 'package:flutter_simple_client/features/PhotosState.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepository _photosRepository;

  PhotosBloc(this._photosRepository);

  @override
  PhotosState get initialState => PhotosState.initial();

  @override
  Stream<PhotosState> mapEventToState(
      PhotosState currentState, PhotosEvent event) async* {
    if (event is LoadNextPageOfPhotosEvent) {
      yield await _loadNextPageOfPhotos(currentState);
    } else if (event is ResetStateEvent) {
      final newState = PhotosState.initial();
      yield newState;
      yield await _loadNextPageOfPhotos(newState);
    }
  }

  void loadNextPageOfPhotos() {
    dispatch(LoadNextPageOfPhotosEvent());
  }

  void resetState() {
    dispatch(ResetStateEvent());
  }

  Future<PhotosState> _loadNextPageOfPhotos(PhotosState currentState) async {
    if (currentState.isEndReached || currentState.isError()) {
      return currentState;
    }

    try {
      var lastPhotoId = -1;

      try {
        lastPhotoId = currentState.photos.last.photoId;
      } catch (e) {
        lastPhotoId = -1;
      }

      final nextPage = await _photosRepository.getPageOfPhotos(lastPhotoId);

      return PhotosState.success(
          currentState.photos + nextPage.data, nextPage.isEnd);
    } on Exception catch (e) {
      return PhotosState.error(currentState.photos, e);
    }
  }
}
