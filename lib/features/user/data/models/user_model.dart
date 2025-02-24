import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_app/features/user/domaine/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? username;
  final String? email;
  final String? phoneNumber;
  final bool? isOnline;
  final String? uid;
  final String? status;
  final String? profileUrl;

  const UserModel(
      {this.username,
      this.email,
      this.phoneNumber,
      this.isOnline,
      this.uid,
      this.status,
      this.profileUrl})
      : super(
          username: username,
          email: email,
          uid: uid,
          profileUrl: profileUrl,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          status: status,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    final snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      username: snap['username'],
      email: snap['email'],
      uid: snap['uid'],
      profileUrl: snap['profileUrl'],
        phoneNumber: snap['phoneNumber'],
        isOnline: snap['isOnline'],
        status: snap['status'],
    );
  }

  Map<String, dynamic> toDocument() => {
    'username': username,
    'email': email,
    'uid': uid,
    'profileUrl': profileUrl,
    'phoneNumber': phoneNumber,
    'isOnline': isOnline,
   'status': status,
  };
}
