import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/model/user_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel userModel = UserModel(userName: '', email: '', profileImage: '');
  File? image;
  final picker = ImagePicker();
  bool isUpload = false;

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
      storeImage();
    } else {
      Fluttertoast.showToast(msg: 'No image selected');
    }
  }

  Future storeImage() async {
    isUpload = true;
    notifyListeners();
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      Reference storageRef = firebaseStorage.ref('profileImage');
      UploadTask uploadTask = storageRef.putFile(image!);
      await Future.value(uploadTask);
      var newUrl = await storageRef.getDownloadURL();

      DocumentReference userRef =
          firestore.collection('Users').doc(auth.currentUser!.uid);
      await userRef.update({'profileImage': newUrl.toString()});
      Fluttertoast.showToast(msg: 'Image Updated');
      getUserData();
      isUpload = false;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      isUpload = false;
      notifyListeners();
      rethrow;
    }
  }

  Stream<UserModel> getUserData() async* {
    yield await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data() as Map<String, dynamic>);
      notifyListeners();
      return userModel;
    });
  }
}
