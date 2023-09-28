import 'package:flutter/material.dart';
import 'package:package_test/drag_and_drop/lib/custom/board.dart';
import 'package:package_test/drag_and_drop/lib/models/inputs.dart';

import 'lib/custom/board.dart';
import 'lib/models/inputs.dart';

class KanbanBoardExample extends StatefulWidget {
  const KanbanBoardExample({super.key});

  @override
  State<KanbanBoardExample> createState() => _KanbanBoardExampleState();
}

class _KanbanBoardExampleState extends State<KanbanBoardExample> {
  @override
  Widget build(BuildContext context) {
    return KanbanBoard(
      [
        BoardListsData(
          title: '1111',
            items: List.generate(
              10,
                  (index) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    )),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Lorem ipsum dolor sit amet, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
            )),
        BoardListsData(
          title: '2222',
          header: Container(child: Text('ssfdsdfasdfa')),
            items: List.generate(
              3,
                  (index) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    )),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Lorem ipsum dolor sit amet, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
            ))
      ],
      onItemLongPress: (cardIndex, listIndex) {},
      onItemReorder:
          (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
        print('item reorder');
          },
      onListLongPress: (listIndex) {},
      onListReorder: (oldListIndex, newListIndex) {},
      onItemTap: (cardIndex, listIndex) {},
      onListTap: (listIndex) {},
      onListRename: (oldName, newName) {},
      backgroundColor: Colors.yellow,
      displacementY: 124,
      displacementX: 100,
      textStyle: const TextStyle(
          fontSize: 50, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}