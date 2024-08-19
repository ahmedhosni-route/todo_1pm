import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_1pm/modules/layout/manager/provider.dart';

import 'widgets/add_task_widget.dart';

class LayoutScreen extends StatelessWidget {
  static const String routeName = "layout";
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: Selector<MainProvider, int>(
        selector: (context, provider) => provider.selectedIndex,
        builder: (context, selectedIndex, child) {
          var provider = Provider.of<MainProvider>(context, listen: false);
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white, width: 4),
                  borderRadius: BorderRadius.circular(360)),
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                        value: provider, child: AddTaskWidget());
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              color: Colors.white,
              child: BottomNavigationBar(
                  currentIndex: selectedIndex,
                  onTap: provider.setIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.menu,
                          size: 30,
                        ),
                        label: "Tasks"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        label: "Settings"),
                  ]),
            ),
            body: provider.screens[selectedIndex],
          );
        },
      ),
    );
  }
}
