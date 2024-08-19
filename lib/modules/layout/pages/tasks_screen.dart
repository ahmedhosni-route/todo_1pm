import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_1pm/core/models/task_model.dart';
import 'package:todo_1pm/modules/layout/manager/provider.dart';

import '../widgets/task_card_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Stack(
              alignment: const Alignment(0, 2),
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Todo List",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                EasyInfiniteDateTimeLine(
                  showTimelineHeader: false,
                  focusDate: provider.selectedData,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChange: provider.setDataTime,
                  activeColor: const Color(0xff5D9CEC),
                  dayProps: EasyDayProps(
                    height: 100,
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    todayHighlightColor: const Color(0xff87baff),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            StreamBuilder(
              stream: provider.getTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text("has Error");
                } else {
                  List<TaskModel> tasks =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCardWidget(taskModel: tasks[index],);
                      },
                    ),
                  );
                }
              },
            )
          ],
        );
      },
    );
  }
}
