
class Photo {
  static const PHOTO_ID_NAME = 'photo_id';
  final int photoId;

  static const USER_ID_NAME = 'user_id';
  final int userId;

  static const PHOTO_NAME_NAME = 'photo_name';
  final String photoName;

  Photo({this.photoId, this.userId, this.photoName});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoId: json[PHOTO_ID_NAME] as int,
      userId: json[USER_ID_NAME] as int,
      photoName: json[PHOTO_NAME_NAME] as String,
    );
  }
}