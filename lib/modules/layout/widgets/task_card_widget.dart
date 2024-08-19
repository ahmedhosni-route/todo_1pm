import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_1pm/core/models/task_model.dart';
import 'package:todo_1pm/core/service/firebase_functions.dart';
import 'package:todo_1pm/modules/layout/manager/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class TaskCardWidget extends StatelessWidget {
  TaskModel taskModel;
  TaskCardWidget({
    required this.taskModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            key: const ValueKey(1),
            startActionPane: ActionPane(
                dismissible: DismissiblePane(onDismissed: () {
                  provider.deleteTask(taskModel.id);
                }),
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(15),
                    onPressed: (_) {
                      provider.deleteTask(taskModel.id);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'delete'.tr(),
                  ),
                  SlidableAction(
                    borderRadius: BorderRadius.circular(15),
                    onPressed: (_) {
                      context.setLocale(const Locale("ar"));
                    },
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'edit'.tr(),
                  )
                ]),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 5,
                    decoration: BoxDecoration(
                        color: taskModel.isDone ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.title,
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                taskModel.isDone ? Colors.green : Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(taskModel.desc),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.timelapse),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(taskModel.time),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      provider.setDone(taskModel);
                    },
                    child: taskModel.isDone
                        ? const Text(
                            "Done..!",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        : Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
