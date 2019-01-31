
class PhotoResponse {
  static const PHOTO_ID_NAME = 'photo_id';
  static const USER_ID_NAME = 'user_id';
  static const PHOTO_NAME_NAME = 'photo_name';

  final int photoId;
  final int userId;
  final String photoName;

  PhotoResponse({this.photoId, this.userId, this.photoName});

  factory PhotoResponse.fromJson(Map<String, dynamic> json) {
    return PhotoResponse(
      photoId: json[PHOTO_ID_NAME] as int,
      userId: json[USER_ID_NAME] as int,
      photoName: json[PHOTO_NAME_NAME] as String
    );
  }
}