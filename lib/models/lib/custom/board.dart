import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Provider/provider_list.dart';
import '../models/board_list.dart' as board_list;
import '../models/inputs.dart';
import 'board_list.dart';
import 'text_field.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard(
    this.list, {
    this.backgroundColor = Colors.white,
    this.cardPlaceHolderColor,
    this.boardScrollConfig,
    this.listScrollConfig,
    this.listPlaceHolderColor,
    this.boardDecoration,
    this.cardTransitionBuilder,
    this.listTransitionBuilder,
    this.cardTransitionDuration = const Duration(milliseconds: 150),
    this.listTransitionDuration = const Duration(milliseconds: 150),
    this.listDecoration,
    this.textStyle,
    this.onItemTap,
    this.displacementX = 0.0,
    this.displacementY = 0.0,
    this.onItemReorder,
    this.onListReorder,
    this.onListRename,
    this.onNewCardInsert,
    this.onItemLongPress,
    this.onListTap,
    this.onListLongPress,
        this.isPossibleReorder,
    super.key,
  });
  final List<BoardListsData> list;
  final Color backgroundColor;
  final ScrollConfig? boardScrollConfig;
  final ScrollConfig? listScrollConfig;
  final Color? cardPlaceHolderColor;
  final Color? listPlaceHolderColor;
  final TextStyle? textStyle;
  final Decoration? listDecoration;
  final Decoration? boardDecoration;
  final void Function(int? cardIndex, int? listIndex)? onItemTap;
  final void Function(int? cardIndex, int? listIndex)? onItemLongPress;
  final void Function(int? listIndex)? onListTap;
  final void Function(int? listIndex)? onListLongPress;
  final void Function(int? oldCardIndex, int? newCardIndex, int? oldListIndex,
      int? newListIndex)? onItemReorder;
  final void Function(int? oldListIndex, int? newListIndex)? onListReorder;
  final void Function(String? oldName, String? newName)? onListRename;
  final void Function(String? cardIndex, String? listIndex, String? text)?
      onNewCardInsert;
  final Widget Function(Widget child, Animation<double> animation)?
      cardTransitionBuilder;
  final Widget Function(Widget child, Animation<double> animation)?
      listTransitionBuilder;
  final double displacementX;
  final double displacementY;
  final Duration cardTransitionDuration;
  final Duration listTransitionDuration;
  final bool? isPossibleReorder;

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Board(widget.list,
          displacementX: widget.displacementX,
          displacementY: widget.displacementY,
          backgroundColor: widget.backgroundColor,
          boardDecoration: widget.boardDecoration,
          cardPlaceHolderColor: widget.cardPlaceHolderColor,
          listPlaceHolderColor: widget.listPlaceHolderColor,
          listDecoration: widget.listDecoration,
          boardScrollConfig: widget.boardScrollConfig,
          listScrollConfig: widget.listScrollConfig,
          textStyle: widget.textStyle,
          onItemTap: widget.onItemTap,
          onItemLongPress: widget.onItemLongPress,
          onListTap: widget.onListTap,
          onListLongPress: widget.onListLongPress,
          onItemReorder: widget.onItemReorder,
          onListReorder: widget.onListReorder,
          onListRename: widget.onListRename,
          onNewCardInsert: widget.onNewCardInsert,
          cardTransitionBuilder: widget.cardTransitionBuilder,
          listTransitionBuilder: widget.listTransitionBuilder,
          cardTransitionDuration: widget.cardTransitionDuration,
          listTransitionDuration: widget.listTransitionDuration,
          isPossibleReorder: widget.isPossibleReorder,
      ),
    ));
  }
}

class Board extends ConsumerStatefulWidget {
  const Board(
    this.list, {
    this.backgroundColor = Colors.white,
    this.cardPlaceHolderColor,
    this.listPlaceHolderColor,
    this.boardDecoration,
    this.boardScrollConfig,
    this.listScrollConfig,
    this.cardTransitionBuilder,
    this.listTransitionBuilder,
    this.cardTransitionDuration = const Duration(milliseconds: 150),
    this.listTransitionDuration = const Duration(milliseconds: 150),
    this.listDecoration,
    this.textStyle,
    this.onItemTap,
    this.displacementX = 0.0,
    this.displacementY = 0.0,
    this.onItemReorder,
    this.onListReorder,
    this.onListRename,
    this.onNewCardInsert,
    this.onItemLongPress,
    this.onListTap,
    this.onListLongPress,
        this.isPossibleReorder,
    super.key,
  });
  final List<BoardListsData> list;
  final Color backgroundColor;
  final Color? cardPlaceHolderColor;
  final Color? listPlaceHolderColor;
  final TextStyle? textStyle;
  final Decoration? listDecoration;
  final Decoration? boardDecoration;
  final ScrollConfig? boardScrollConfig;
  final ScrollConfig? listScrollConfig;
  final void Function(int? cardIndex, int? listIndex)? onItemTap;
  final void Function(int? cardIndex, int? listIndex)? onItemLongPress;
  final void Function(int? listIndex)? onListTap;
  final void Function(int? listIndex)? onListLongPress;
  final void Function(int? oldCardIndex, int? newCardIndex, int? oldListIndex,
      int? newListIndex)? onItemReorder;
  final void Function(int? oldListIndex, int? newListIndex)? onListReorder;
  final void Function(String? oldName, String? newName)? onListRename;
  final void Function(String? cardIndex, String? listIndex, String? text)?
      onNewCardInsert;
  final Widget Function(Widget child, Animation<double> animation)?
      cardTransitionBuilder;
  final Widget Function(Widget child, Animation<double> animation)?
      listTransitionBuilder;
  final double displacementX;
  final double displacementY;
  final Duration cardTransitionDuration;
  final Duration listTransitionDuration;
  final bool? isPossibleReorder;

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {

  bool _isScrollButtonShow = false;

  @override
  void initState() {
    var boardProv = ref.read(ProviderList.boardProvider);
    var boardListProv = ref.read(ProviderList.boardListProvider);
    boardProv.initializeBoard(
        data: widget.list,
        boardScrollConfig: widget.boardScrollConfig,
        listScrollConfig: widget.listScrollConfig,
        displacementX: widget.displacementX,
        displacementY: widget.displacementY,
        backgroundColor: widget.backgroundColor,
        boardDecoration: widget.boardDecoration,
        cardPlaceHolderColor: widget.cardPlaceHolderColor,
        listPlaceHolderColor: widget.listPlaceHolderColor,
        listDecoration: widget.listDecoration,
        textStyle: widget.textStyle,
        onItemTap: widget.onItemTap,
        onItemLongPress: widget.onItemLongPress,
        onListTap: widget.onListTap,
        onListLongPress: widget.onListLongPress,
        onItemReorder: widget.onItemReorder,
        onListReorder: widget.onListReorder,
        onListRename: widget.onListRename,
        onNewCardInsert: widget.onNewCardInsert,
        cardTransitionBuilder: widget.cardTransitionBuilder,
        listTransitionBuilder: widget.listTransitionBuilder,
        cardTransitionDuration: widget.cardTransitionDuration,
        listTransitionDuration: widget.listTransitionDuration);

    for (var element in boardProv.board.lists) {
      // List Scroll Listener
      element.scrollController.addListener(() {
        if (boardListProv.scrolling) {
          if (boardListProv.scrollingDown) {
            boardProv.valueNotifier.value = Offset(
                boardProv.valueNotifier.value.dx,
                boardProv.valueNotifier.value.dy + 0.00001);
          } else {
            boardProv.valueNotifier.value = Offset(
                boardProv.valueNotifier.value.dx,
                boardProv.valueNotifier.value.dy + 0.00001);
          }
        }
        /// 기준선 이하로 스크롤 내렸을 때 스크롤 버튼 보이게 처리
        if (!_isScrollButtonShow && element.scrollController.offset > 1000) {
          setState(() {
            _isScrollButtonShow = !_isScrollButtonShow;
          });
        } else if (_isScrollButtonShow && element.scrollController.offset < 1000) {
          setState(() {
            _isScrollButtonShow = !_isScrollButtonShow;
          });
        }
      });
    }

    // Board Scroll Listener
    boardProv.board.controller.addListener(() {
      if (boardProv.scrolling) {
        if (boardProv.scrollingLeft && boardProv.board.isListDragged) {
          for (var element in boardProv.board.lists) {
            if (element.context == null) break;
            var of = (element.context!.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
            element.x = of.dx - boardProv.board.displacementX! - 10;
            element.width = element.context!.size!.width - 30;
            element.y = of.dy - widget.displacementY + 24;
          }
          // boardListProv.moveListLeft();
        } else if (boardProv.scrollingRight && boardProv.board.isListDragged) {
          for (var element in boardProv.board.lists) {
            if (element.context == null) break;
            var of = (element.context!.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
            element.x = of.dx - boardProv.board.displacementX! - 10;
            element.width = element.context!.size!.width - 30;
            element.y = of.dy - widget.displacementY + 24;
          }
          boardListProv.moveListRight();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var boardProv = ref.read(ProviderList.boardProvider);
    var boardListProv = ref.read(ProviderList.boardListProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      boardProv.board.setstate = () => setState(() {});
      var box = context.findRenderObject() as RenderBox;
      boardProv.board.displacementX =
          box.localToGlobal(Offset.zero).dx - 10; //- margin
      boardProv.board.displacementY =
          box.localToGlobal(Offset.zero).dy + 24; // statusbar
    });
    return Listener(
      onPointerUp: (event) {
        if (boardProv.board.isElementDragged || boardProv.board.isListDragged) {
          if (boardProv.board.isElementDragged) {
            ref.read(ProviderList.cardProvider).reorderCard();
          }
          boardProv.setcanDrag(value: false, listIndex: 0, itemIndex: 0);
          setState(() {});
        }
      },
      onPointerMove: (event) {
        if (boardProv.board.isElementDragged) {
          if (event.delta.dx > 0) {
            boardProv.boardScroll();
          } else {
            boardProv.boardScroll();
          }
        } else if (boardProv.board.isListDragged) {
          if (event.delta.dx > 0) {
            boardProv.boardScroll();
            boardListProv.moveListRight();
          } else {
            boardProv.boardScroll();
            boardListProv.moveListLeft();
          }
        }
        boardProv.valueNotifier.value = Offset(
            event.delta.dx + boardProv.valueNotifier.value.dx,
            event.delta.dy + boardProv.valueNotifier.value.dy);
      },
      child: GestureDetector(
        onTap: () {
          if (boardProv.board.newCardFocused == true) {
            ref.read(ProviderList.cardProvider).saveNewCard();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: widget.boardDecoration ??
                BoxDecoration(color: widget.backgroundColor),
            /// 최상단 마진
            margin: const EdgeInsets.only(top: 24),
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.none,
              children: [
                Container(
                  /// 최좌측 마진
                  margin: const EdgeInsets.only(left: 20),
                  //width: 200,
                  // height: 1200,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                      },
                    ),
                    child: SingleChildScrollView(
                      controller: boardProv.board.controller,
                      scrollDirection: Axis.horizontal,
                      child: Transform(
                        alignment: Alignment.topLeft,
                        // scaleX: 0.45,
                        transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                            1, 0, 0, 0, 0, 1),
                        child: Row(
                            children: boardProv.board.lists
                                .map(
                                    (e) =>
                                        BoardList(
                                                index: boardProv
                                                    .board.lists
                                                    .indexOf(e),
                                            isPossibleReorder: widget.isPossibleReorder ?? false,
                                              )
                            )
                                .toList()),
                      ),
                    ),
                  ),
                ),
                /// 드래그로 이동하는 동안 보일 위젯
                ValueListenableBuilder(
                  valueListenable: boardProv.valueNotifier,
                  builder: (ctx, Offset value, child) {
                    if (boardProv.board.isElementDragged) {
                      boardListProv.maybeListScroll();
                    }
                    return boardProv.board.isElementDragged ||
                            boardProv.board.isListDragged
                        ? Positioned(
                            left: value.dx,
                            top: value.dy,
                            child: Opacity(
                              opacity: 0.7,
                              child: boardProv.draggedItemState!.child,
                            ),
                          )
                        : Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
