class UserModel {
  final String uuid;
  final String nickname;
  final String fcmToken;
  final String accessToken;

  UserModel({
    required this.uuid,
    required this.nickname,
    required this.fcmToken,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uuid: json['uuid'],
        nickname: json['nickname'],
        fcmToken: json['fcmToken'],
        accessToken: json['accessToken'],
    );
  }
}