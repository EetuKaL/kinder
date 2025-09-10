import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kinderfrontend/utils/firestore_utilities.dart';
import 'package:kinderfrontend/models/profile.dart';

enum CardStatus { like, dislike, superLike }

// Provider to hold all data for the cards.

class CardProvider extends ChangeNotifier {
  List<Profile> _profiles = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;
  bool _isLoading = true;

  List<Profile> get profiles => _profiles;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  Size get screensize => _screenSize;
  double get angle => _angle;
  bool get isLoading => _isLoading;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void setProfiles(Profile profile) {
    _profiles.add(profile);
  }

  Future<void> initProfiles() async {
    _profiles = await getLocalProfiles();
    _isLoading = false;
    notifyListeners();
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
    if (_profiles.isEmpty) return;
    // wait some time for the animation to finish.
    await Future.delayed(const Duration(milliseconds: 200));
    _profiles.removeLast();
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
