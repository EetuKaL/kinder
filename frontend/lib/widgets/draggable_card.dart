import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_card.dart';
import 'dart:math' as math;

class DraggableCard extends StatefulWidget {
  String imageUrls;
  int profileAge;
  String profileName;
  String profileJob;
  String profileJobAt;
  List<Widget> cardList;

  DraggableCard(
      {super.key,
      required this.imageUrls,
      required this.profileAge,
      required this.profileJob,
      required this.profileJobAt,
      required this.profileName,
      required this.cardList});

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  double currentPosition = 0;
  double oldPosition = 0;

  void _handleDragging(x) {
    setState(() {
      oldPosition = currentPosition;
    });
  }

  void _removeCard() {
    setState(() {
      widget.cardList.removeAt(widget.cardList.length - 1);
    });
  }

  /* void _handleOldPosition(x) {
    setState(() {
      oldPosition = x;
    });
  }
 */
  void _handleCurrentPosition(x) {
    setState(() {
      currentPosition = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      onDragStarted: () {},
      onDragEnd: (drag) {
        print(drag.offset.dx);
        if (drag.offset.dx < -150) {
          print('Swiped left');
        } else if (drag.offset.dx > 150) {
          print('swiped Right');
          setState(() {});
          (() {
            _removeCard();
          });
        } else {
          print('not meant to swipe');
        }
        print('printataan päättynyt drag ${drag.offset.dx}');
      },
      onDragUpdate: (drag) {
        _handleCurrentPosition(drag.localPosition.dx);

        print('printataan drag global: ${drag.globalPosition.dx}');
        print('printataan drag local: ${drag.localPosition.dx}');
      },
      feedback: Transform.rotate(
        angle: currentPosition < 150 ? math.pi / 12 : -math.pi / 12,
        child: Profile_Card(
          image: widget.imageUrls,
          age: widget.profileAge,
          name: widget.profileName,
          job: widget.profileJob,
          jobAt: widget.profileJobAt,
        ),
      ),
      child: Profile_Card(
        image: widget.imageUrls,
        age: widget.profileAge,
        name: widget.profileName,
        job: widget.profileJob,
        jobAt: widget.profileJobAt,
      ),
      childWhenDragging: Container(),
    );
  }
}
