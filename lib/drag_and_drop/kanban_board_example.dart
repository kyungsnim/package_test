import 'package:flutter/material.dart';
import 'package:package_test/_importer.dart';
import 'package:provider/provider.dart';

class KanbanBoardExample extends StatefulWidget {
  const KanbanBoardExample({super.key});

  @override
  State<KanbanBoardExample> createState() => _KanbanBoardExampleState();
}

class _KanbanBoardExampleState extends State<KanbanBoardExample> {
  @override
  void initState() {
    final curriculumState =
        Provider.of<CurriculumState>(context, listen: false);
    curriculumState.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final curriculumState = Provider.of<CurriculumState>(context);

    return KanbanBoard(
      [
        BoardListsData(
          // title: '1111',
          items: curriculumState.dragAndDropList,
          headerBackgroundColor: Colors.white,
          isPossibleReorder: false,
        ),
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
          ),
          isPossibleReorder: true,
          footer: Text('123132'),
          footerBackgroundColor: Colors.green,
        ),
      ],
      onItemLongPress: (cardIndex, listIndex) {},
      onItemReorder: (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
        print('item reorder');
      },
      onListLongPress: (listIndex) {},
      onListReorder: (oldListIndex, newListIndex) {},
      onItemTap: (cardIndex, listIndex) {},
      onListTap: (listIndex) {},
      onListRename: (oldName, newName) {},
      backgroundColor: Colors.white,
      displacementY: 124,
      displacementX: 100,

      /// header text style
      textStyle: const TextStyle(
          fontSize: 50, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}
