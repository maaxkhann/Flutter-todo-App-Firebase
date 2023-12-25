import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/view/tasks_view/add_tasks_view.dart';
import 'package:to_do_app/view_model/tasks_view_model.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksViewModel = Provider.of<TasksViewModel>(context, listen: true);
    final size = MediaQuery.of(context).size; // Corrected MediaQuery size access
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.4),
                    Colors.grey.withOpacity(0.5),
                  ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Text('Your Tasks', style: kHead1,),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: tasksViewModel.fetchTasks(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: SpinKitFadingCircle(color: Colors.black,)); // Show a loader while waiting for data
                    } else if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return const Center(child: Text('Error'));
                    }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                              leading: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                              title: Text(task?.taskName ?? ''),
                              subtitle: Text(task?.date ?? ''),
                              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                            ),
                          );
                        },
                      );
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
