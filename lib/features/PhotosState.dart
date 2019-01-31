
import 'package:flutter_simple_client/core/AbstractState.dart';
import 'package:flutter_simple_client/data/Photo.dart';

class PhotosState extends AbstractState {
  var photos = new List<Photo>();
  var isEndReached = false;
  Exception exception;

  PhotosState._();

  PhotosState(this.photos, this.isEndReached, this.exception);

  factory PhotosState.initial() {
    return PhotosState([], false, null);
  }

  factory PhotosState.success(List<Photo> newPhotos, bool isEndReached) {
    return PhotosState(newPhotos, isEndReached, null);
  }

  factory PhotosState.error(List<Photo> oldPhotos, Exception exception) {
    return PhotosState(oldPhotos, false, exception);
  }

  @override
  bool isError() => exception != null;

  @override
  bool isSuccess() => exception == null;
}