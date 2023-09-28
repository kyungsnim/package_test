import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_test/drag_and_drop/kanban_board_example.dart';
import '_importer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => Get.to(() => SplitViewPage()), child: Text('Split view')),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () => Get.to(() => EntryPage()), child: Text('Brain map > entry')),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () => Get.to(() => PageViewPage()), child: Text('Page view > page view')),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () => Get.to(() => PageViewPage2()), child: Text('Page view > page view2')),
        // SizedBox(height: 10),
        // ElevatedButton(onPressed: () => Get.to(() => PreloadPageViewDemo()), child: Text('Page view > preload page view')),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () => Get.to(() => KanbanBoardExample()), child: Text('Drag and drop > Kanban board view')),
      ],
    );
  }
}
