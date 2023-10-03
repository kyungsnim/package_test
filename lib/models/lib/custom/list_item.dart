import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Provider/provider_list.dart';

class Item extends ConsumerStatefulWidget {
  const Item({
    super.key,
    required this.itemIndex,
    this.color = Colors.pink,
    required this.listIndex,
    required this.isPossibleReorder,
  });
  final int itemIndex;
  final int listIndex;
  final Color color;
  final bool isPossibleReorder;
  @override
  ConsumerState<Item> createState() => _ItemState();
}

class _ItemState extends ConsumerState<Item> {
  Offset location = Offset.zero;
  bool newAdded = false;
  var node = FocusNode();
  @override
  Widget build(BuildContext context) {
    // log("BUILDED ${widget.itemIndex}");
    var prov = ref.read(ProviderList.boardProvider.notifier);
    var cardProv = ref.read(ProviderList.cardProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cardProv.calculateCardPositionSize(
          listIndex: widget.listIndex,
          itemIndex: widget.itemIndex,
          context: context,
          setState: () => {setState(() {})});
    });
    return ValueListenableBuilder(
        valueListenable: prov.valueNotifier,
        builder: (ctx, a, b) {
          if (prov.board.isElementDragged == true) {
            // item added by system in empty list, its widget/UI should not be manipulated on movements //
            if (prov.board.lists[widget.listIndex].items.isEmpty) return b!;

            // CALCULATE SIZE AND POSITION OF ITEM //
            if (cardProv.calculateSizePosition(
                listIndex: widget.listIndex, itemIndex: widget.itemIndex)) {
              return b!;
            }

            // IF ITEM IS LAST ITEM OF LIST, DIFFERENT APPROACH IS USED //

            if (cardProv.isLastItemDragged(
                listIndex: widget.listIndex, itemIndex: widget.itemIndex)) {
              // log("LAST ELEMENT DRAGGED");
              return b!;
            }

            // DO NOT COMPARE ANYTHING WITH DRAGGED ITEM, IT WILL CAUSE ERRORS BECUSE ITS HIDDEN //
            if ((prov.draggedItemState!.itemIndex == widget.itemIndex &&
                prov.draggedItemState!.listIndex == widget.listIndex)) {
              // log("HERE");
              return b!;
            }

            // if (widget.itemIndex - 1 >= 0 &&
            //     prov.board.lists[widget.listIndex].items[widget.itemIndex - 1]
            //             .containsPlaceholder ==
            //         true) {
            // //  log("FOR ${widget.listIndex} ${widget.itemIndex}");
            //   prov.board.lists[widget.listIndex].items[widget.itemIndex].y =
            //       prov.board.lists[widget.listIndex].items[widget.itemIndex]
            //               .y! -
            //           prov.board.lists[widget.listIndex].items[widget.itemIndex-1].actualSize!.height;
            // }

            if (cardProv.getYAxisCondition(
                listIndex: widget.listIndex, itemIndex: widget.itemIndex)) {
            // log("Y AXIS CONDITION");
              /// 좌측 리스트에는 reorder 불가능하게 설정
              if (prov.board.lists[widget.listIndex].isPossibleReorder ?? false) {
                cardProv.checkForYAxisMovement(
                    listIndex: widget.listIndex, itemIndex: widget.itemIndex);
              }
            } else if (cardProv.getXAxisCondition(
                listIndex: widget.listIndex, itemIndex: widget.itemIndex)) {
              /// 우측 리스트에는 좌측으로 못넘기게 설정
              if (prov.board.lists[widget.listIndex].isPossibleReorder ?? false) {
                cardProv.checkForXAxisMovement(
                    listIndex: widget.listIndex, itemIndex: widget.itemIndex);
              }
            }
          }
          return b!;
        },
        child: GestureDetector(
          onLongPress: () {
            cardProv.onLongPressCard(
                listIndex: widget.listIndex,
                itemIndex: widget.itemIndex,
                context: context,
                setState: () => {setState(() {})});
          },
          child: prov.board.isElementDragged &&
                  prov.board.dragItemIndex == widget.itemIndex &&
                  prov.draggedItemState!.itemIndex == widget.itemIndex &&
                  prov.draggedItemState!.listIndex == widget.listIndex &&
                  prov.board.dragItemOfListIndex! == widget.listIndex
              ?
              /// 드래그하는 아이템이 현재 index에 위치했을 때 보여질 위젯
          Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                    // color: prov.board.lists[widget.listIndex]
                    //         .items[widget.itemIndex].backgroundColor ??
                    //     Colors.white,
                  ),
                  width: prov.draggedItemState!.width,
                  height: prov.draggedItemState!.height,
            child: prov.draggedItemState!.child,
                )
              : cardProv.isCurrentElementDragged(
                      listIndex: widget.listIndex, itemIndex: widget.itemIndex)
                  ? Container(
color: Colors.blue,
                      )
                  : /// 리스트아이템 하위 빈칸 영역
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: prov.board.lists[widget.listIndex]
                          .items[widget.itemIndex].width,
                      child: prov.board.lists[widget.listIndex]
                          .items[widget.itemIndex].child,
                    ),
        ));
  }
}
