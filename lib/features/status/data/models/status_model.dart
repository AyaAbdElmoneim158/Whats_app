import 'package:cloud_firestore/cloud_firestore.dart';

import 'status_image_model.dart';

class StatusModel {
  final String? statusId;
  final String? imageUrl;
  final String? uid;
  final String? username;
  final String? profileUrl;
  final Timestamp? createdAt;
  final String? phoneNumber;
  final String? caption;
  final List<StatusImageModel>? stories;

  StatusModel(
      {this.statusId,
      this.imageUrl,
      this.uid,
      this.username,
      this.profileUrl,
      this.createdAt,
      this.phoneNumber,
      this.caption,
      this.stories});

  factory StatusModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    final stories = snap['stories'] as List;
    List<StatusImageModel> storiesData =
        stories.map((element) => StatusImageModel.fromJson(element)).toList();

    return StatusModel(
        stories: storiesData,
        statusId: snap['statusId'],
        username: snap['username'],
        phoneNumber: snap['phoneNumber'],
        createdAt: snap['createdAt'],
        uid: snap['uid'],
        profileUrl: snap['profileUrl'],
        imageUrl: snap['imageUrl'],
        caption: snap['caption']);
  }

  Map<String, dynamic> toDocument() => {
        "stories": stories?.map((story) => story.toJson()).toList(),
        "statusId": statusId,
        "username": username,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt,
        "uid": uid,
        "profileUrl": profileUrl,
        "imageUrl": imageUrl,
        "caption": caption,
      };
}
