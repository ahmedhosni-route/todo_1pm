import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_1pm/modules/layout/manager/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text("Add New Task"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: provider.titleController,
                decoration: InputDecoration(
                  hintText: "title".tr(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: provider.descController,
                decoration: InputDecoration(
                  hintText: "desc".tr(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Selected Date"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: provider.selectedDataTime,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)))
                        .then((value) {
                      provider.setDataTimeTask(value!);
                    });
                  },
                  child: Text(
                      provider.selectedDataTime.toString().substring(0, 10))),
              const SizedBox(
                height: 10,
              ),
              const Text("Selected Time"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    showTimePicker(context: context, initialTime: provider.time).then((value) {
                      provider.setTime(value!);
                    });
                  },
                  child: Text("${provider.time.hour} : ${provider.time.minute}"),),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    provider.addTask();
                    Navigator.pop(context);
                  },
                  child: const Text("Add Task"))
            ],
          ),
        );
      },
    );
  }
}
