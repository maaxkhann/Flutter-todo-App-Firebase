import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/task_model.dart';

class TasksViewModel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isCompleted = false;
  Stream<List<TaskModel>>? tasks;
//  List<TaskModel> tasks = [];

  Future<void> addTasks(String taskName,) async {
    isCompleted = true;
    String uId = auth.currentUser!.uid;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy h:mm:a').format(now);
    notifyListeners();
    try {
      DocumentReference taskRef = firestore.collection('tasks').doc(uId).collection('tasks').doc();
      await taskRef.set({
        'taskName' : taskName,
        'Date' : formattedDate,
        'taskId' : taskRef.id
      });
      isCompleted = false;
      Fluttertoast.showToast(msg: 'Task Added');
      notifyListeners();
    }catch(e) {
      isCompleted = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
      notifyListeners();
      rethrow;
    }
  }

  Stream<List<TaskModel>> fetchTasks() {
    try {
      String uId = auth.currentUser!.uid;
      var taskSnapshot = firestore.collection('tasks').doc(uId).collection('tasks').snapshots();
      tasks = taskSnapshot.map(
            (QuerySnapshot querySnapshot) {
            List<TaskModel> taskList = querySnapshot.docs.map(
                    (doc) {
                  TaskModel taskModel = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
                  return taskModel;
                },
              ).toList();
            taskList.sort((a, b) {
              try {
                DateTime dateA = DateFormat('dd-MM-yyyy').parse(a.date);
                DateTime dateB = DateFormat('dd-MM-yyyy').parse(b.date);
                return dateB.compareTo(dateA);
              } catch (e) {
                print('Error parsing date: $e');
                // Handle the error gracefully, for example, by placing unparsable dates at the end
                return 1;
              }
            });
            return taskList;
            }
      );
      return tasks!;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      print(e.toString());
      rethrow;
    }
  }
}