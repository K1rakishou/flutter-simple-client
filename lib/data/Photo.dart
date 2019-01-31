
import 'package:flutter_simple_client/data/PhotoResponse.dart';

class Photo {
  final int photoId;
  final int userId;
  final String photoName;

  Photo({this.photoId, this.userId, this.photoName});

  factory Photo.fromResponse(PhotoResponse response) {
    return Photo(
        photoId: response.photoId,
        userId: response.userId,
        photoName: response.photoName
    );
  }
}