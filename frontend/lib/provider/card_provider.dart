import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CardStatus { like, dislike, superLike }

// Provider to hold all data for the cards.

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  Size get screensize => _screenSize;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }
  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void resetUsers() {
    _urlImages = <String>[
      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1288&q=80",
      "https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1476&q=80"
    ];
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final xCardPosition = _position.dx;

    _angle = 45 * xCardPosition / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();
    if (status != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: status.toString().split('.').last.toUpperCase(),
        fontSize: 36,
      );
    }

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
      case CardStatus.superLike:
        superLike();
      default:
        resetPosition();
    }
  }

  CardStatus? getStatus() {
    final xCardPosition = _position.dx;
    final yCardPosition = _position.dy;
    const likePos = 100;
    const dislikePos = -100;
    final forceSuperLike = xCardPosition.abs() < 20;

    if (xCardPosition >= likePos) {
      return CardStatus.like;
    } else if (xCardPosition <= dislikePos) {
      return CardStatus.dislike;
    } else if (yCardPosition <= dislikePos && forceSuperLike) {
      return CardStatus.superLike;
    }
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width / 2, 0);
    _nextCard();
    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width / 2, 0);
    _nextCard();
    notifyListeners();
  }

  void superLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (_urlImages.isEmpty) return;
    // wait some time for the animation to finish.
    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  void setScreenSize(size) => _screenSize = size;
}
