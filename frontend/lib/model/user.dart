import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? key;
  String? email;
  String? userId;
  String? displayName;
  String? profilePic;
  String? createAt;
  String? fcmToken;

  UserModel(
      {this.email,
      this.key,
      this.userId,
      this.displayName,
      this.profilePic,
      this.createAt,
      this.fcmToken});

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    email = map['email'];
    userId = map['userId'];
    displayName = map['displayName'];
    profilePic = map['profilePic'];
    key = map['key'];
    createAt = map['createAt'];
    fcmToken = map['fcmToken'];
  }
  toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      'displayName': displayName,
      'createAt': createAt,
      'profilePic': profilePic,
      'fcmToken': fcmToken
    };
  }

  UserModel copyWith({
    String? email,
    String? userId,
    String? displayName,
    String? profilePic,
    String? key,
    String? fcmToken,
  }) {
    return UserModel(
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        key,
        email,
        userId,
        createAt,
        displayName,
        fcmToken,
        profilePic,
      ];
}
