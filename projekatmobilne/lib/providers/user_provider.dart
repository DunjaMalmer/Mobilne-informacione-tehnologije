import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekatmobilne/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;

  Future<UserModel?> fetchUserInfo() async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      userModel = null;
      return null;
    }

    final String uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userDocDict = userDoc.data();
      if (userDocDict == null) {
        userModel = null;
        return null;
      }

      userModel = UserModel(
        userId: userDoc.get("userId"),
        userName: userDoc.get("userName"),
        userImage: userDoc.get("userImage"),
        userEmail: userDoc.get("userEmail"),
        userCart: userDocDict.containsKey("userCart") ? userDoc.get("userCart") : [],
        userWish: userDocDict.containsKey("userWish") ? userDoc.get("userWish") : [],
        createdAt: userDoc.get("createdAt"),
      );
      notifyListeners();
      return userModel;
    } on FirebaseException {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
