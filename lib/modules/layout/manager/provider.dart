import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_1pm/core/models/task_model.dart';
import 'package:todo_1pm/core/service/firebase_functions.dart';
import 'package:todo_1pm/modules/layout/pages/settings_screen.dart';
import 'package:todo_1pm/modules/layout/pages/tasks_screen.dart';

class MainProvider extends ChangeNotifier {
  int selectedIndex = 0;
  DateTime selectedData = DateTime.now();
  DateTime selectedDataTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List<Widget> screens = [TasksScreen(), SettingsScreen()];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setDataTime(DateTime dateTime) {
    selectedData = dateTime;
    notifyListeners();
  }

  void setDataTimeTask(DateTime dateTime) {
    selectedDataTime = dateTime;
    notifyListeners();
  }

  void addTask() async {
    TaskModel taskModel = TaskModel(
        title: titleController.text,
        desc: descController.text,
        time: "${time.hour} : ${time.minute}",
        date: DateUtils.dateOnly(selectedDataTime).millisecondsSinceEpoch,
        isDone: false);
    await FirebaseFunctions.addTask(taskModel);
    titleController.clear();
    descController.clear();
    // notifyListeners();
  }

  Stream<QuerySnapshot<TaskModel>> getTask() {
    return FirebaseFunctions.getTasks(selectedData);
  }

  void deleteTask(String id) {
    FirebaseFunctions.deleteTask(id);
    // notifyListeners();
  }

  void setDone(TaskModel task) {
    FirebaseFunctions.setDone(task);
    // notifyListeners();
  }

  void setTime(TimeOfDay value) {
    time = value;
    notifyListeners();
  }
}
