import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/view/profile_view/user_profile_view.dart';
import 'package:to_do_app/view/tasks_view/add_tasks_view.dart';
import 'package:to_do_app/view_model/tasks_view_model.dart';

class TasksListView extends StatelessWidget {
  TasksListView({Key? key}) : super(key: key);
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tasksViewModel = Provider.of<TasksViewModel>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.grey.withOpacity(0.4),
            Colors.grey.withOpacity(0.5),
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Tasks',
                      style: kHead1,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: IconButton(
                            onPressed: () =>
                                Get.to(() => const UserProfileView()),
                            icon: const Icon(Icons.person),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              AlertDialog(
                                title: const Text('Are you sure to logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () => tasksViewModel.signOut(),
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text('No')),
                                ],
                              ).show(context);
                            },
                            child: const Icon(Icons.logout))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: tasksViewModel.fetchTasks(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCircle(
                        color: Colors.black,
                      )); // Show a loader while waiting for data
                    } else {
                      final tasks = snapshot.data;
                      if (tasks == null || tasks.isEmpty) {
                        return const Center(
                            child: Text(
                          'No Tasks',
                          style: kHead2,
                        ));
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        // Handle the case when there is no data
                        return const Center(
                          child: Text('No tasks available.'),
                        );
                      } else {
                        final tasks = snapshot.data;
                        return ListView.builder(
                          itemCount: tasks?.length,
                          itemBuilder: (ctx, index) {
                            final task = tasks?[index];
                            return Card(
                              color: Colors.grey.shade200,
                              child: ListTile(
                                leading: IconButton(
                                    onPressed: () {
                                      taskController.text = task!.taskName;
                                      AlertDialog(
                                        title: TextField(
                                          controller: taskController,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                tasksViewModel.updateTask(
                                                    task.taskId,
                                                    taskController.text);
                                                Get.back();
                                              },
                                              child: const Text('Update')),
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('No')),
                                        ],
                                      ).show(context);
                                    },
                                    icon: const Icon(Icons.edit)),
                                title: Text(task?.taskName ?? ''),
                                subtitle: Text(task?.date ?? ''),
                                trailing: IconButton(
                                    onPressed: () {
                                      AlertDialog(
                                        title: const Text(
                                            'Are you sure to delete this task?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                tasksViewModel
                                                    .deleteTask(task!.taskId);
                                                Get.back();
                                              },
                                              child: const Text('Yes')),
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('No')),
                                        ],
                                      ).show(context);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => AddTasksView()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
