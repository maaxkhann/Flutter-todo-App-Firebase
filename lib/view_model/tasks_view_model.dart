import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/view/auth_view/login_view.dart';

class TasksViewModel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  DocumentReference? taskRef;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TaskModel taskModel = TaskModel(taskName: '', taskId: '', date: '');
  String? uId;
  bool isCompleted = false;
  Stream<List<TaskModel>>? tasks;

  DateTime now = DateTime.now();

  Future<void> addTasks(String taskName) async {
    isCompleted = true;
    uId = auth.currentUser!.uid;
    notifyListeners();
    try {
      String formattedDate = DateFormat('dd-MM-yyyy h:mm:a').format(now);
      taskRef =
          firestore.collection('tasks').doc(uId).collection('tasks').doc();
      await taskRef!.set(
          {'taskName': taskName, 'Date': formattedDate, 'taskId': taskRef?.id});
      isCompleted = false;
      Fluttertoast.showToast(msg: 'Task Added');
      Get.back();
      notifyListeners();
    } catch (e) {
      isCompleted = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
      notifyListeners();
      rethrow;
    }
  }

  Stream<List<TaskModel>> fetchTasks() {
    try {
      uId = auth.currentUser!.uid;
      var taskSnapshot = firestore
          .collection('tasks')
          .doc(uId)
          .collection('tasks')
          .orderBy('Date', descending: true)
          .snapshots();
      tasks = taskSnapshot.map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            taskModel = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
            return taskModel;
          },
        ).toList();
      });
      return tasks!;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      rethrow;
    }
  }

  void signOut() async {
    await auth.signOut().then((value) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
      Get.offAll(() => LoginView());
    });
  }

  void deleteTask(String taskId) async {
    await firestore
        .collection('tasks')
        .doc(uId)
        .collection('tasks')
        .doc(taskId)
        .delete();
    Fluttertoast.showToast(msg: 'Task deleted');
  }

  void updateTask(String taskId, String taskName) async {
    await firestore
        .collection('tasks')
        .doc(uId)
        .collection('tasks')
        .doc(taskId)
        .update({'taskName': taskName});
    Fluttertoast.showToast(msg: 'Task updated');
  }
}
