import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/view/constant_widgets/constant_button.dart';
import 'package:to_do_app/view/constant_widgets/constant_textfield.dart';
import 'package:to_do_app/view_model/tasks_view_model.dart';

class AddTasksView extends StatelessWidget {
  AddTasksView({Key? key}) : super(key: key);
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tasksViewModel = Provider.of<TasksViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height * 1,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.grey.withOpacity(0.4),
              Colors.grey.withOpacity(0.5),
            ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Your Tasks Here',
                  style: kHead1,
                ),
                SizedBox(
                  height: Get.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ConstantTextField(
                          controller: taskController,
                          hintText: 'Add Task',
                          prefixIcon: Icons.task),
                      Consumer<TasksViewModel>(
                        builder: (context, value, child) {
                          return ConstantButton(
                              text: 'Add Task',
                              buttonColor: kButtonColor,
                              textColor: kWhite,
                              isCompleted: value.isCompleted,
                              onTap: () {
                                tasksViewModel
                                    .addTasks(taskController.text.trim());
                              });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
