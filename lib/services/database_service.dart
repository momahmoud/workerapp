

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workerapp/models/user_model.dart';
import 'package:workerapp/utils/constant.dart';

class DatabaseService {
  static void updateUser(UserModel user) {
    postsRef.document(user.id).updateData({
      'imageUrl': user.imageUrl,
      'name': user.name,
      'skills': user.skills,
      'phone': user.phone,
      'address': user.address,
      'age': user.age
    });
  }

  // static Future<QuerySnapshot> searchUsers(String name) {
  //   Future<QuerySnapshot> users =
  //       usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
  //   return users;
  // }

  static void createPost(UserModel user) {
    postsRef.document(user.id).collection('userPost').add({
      'imageUrl': user.imageUrl,
      'name': user.name,
      'skills': user.skills,
      'phone': user.phone,
      'address': user.address,
      'age': user.age
    });
  }

  // static void followUser(String currentUserID, String userId) {
  //   followingRef
  //       .document(currentUserID)
  //       .collection('userFollowing')
  //       .document(userId)
  //       .setData({});

  //   followersRef
  //       .document(userId)
  //       .collection('userFollowers')
  //       .document(currentUserID)
  //       .setData({});
  // }

  // static void unfollowUser(String currentUserID, String userId) {
  //   followingRef
  //       .document(currentUserID)
  //       .collection('userFollowing')
  //       .document(userId)
  //       .get()
  //       .then((doc) {
  //     if (doc.exists) {
  //       doc.reference.delete();
  //     }
  //   });

  //   followersRef
  //       .document(userId)
  //       .collection('userFollowers')
  //       .document(currentUserID)
  //       .get()
  //       .then((doc) {
  //     if (doc.exists) {
  //       doc.reference.delete();
  //     }
  //   });
  // }

  // static Future<bool> isFollowingUser(
  //     {String currentUserId, String userId}) async {
  //   DocumentSnapshot followingDoc = await followersRef
  //       .document(userId)
  //       .collection('userFollowers')
  //       .document(currentUserId)
  //       .get();
  //   return followingDoc.exists;
  // }

  // static Future<int> numFollowers(String userId) async {
  //   QuerySnapshot followersSnapshot = await followersRef
  //       .document(userId)
  //       .collection('userFollowers')
  //       .getDocuments();
  //   return followersSnapshot.documents.length;
  // }

  // static Future<int> numFollowing(String userId) async {
  //   QuerySnapshot followingSnapshot = await followingRef
  //       .document(userId)
  //       .collection('userFollowing')
  //       .getDocuments();
  //   return followingSnapshot.documents.length;
  // }
}
