
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
 final String taskName;
 final String taskId;
 final String date;

  TaskModel({required this.taskName, required this.taskId, required this.date});

 factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskName : map['taskName'],
        taskId : map['taskId'],
        date : map['Date']
    );
  }
}