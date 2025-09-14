import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/state/card/card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit({required Size screenSize})
      : super(CardState(screensize: screenSize));

  void startPosition(DragStartDetails details) {
    emit(state.copyWith(isDragging: true));
  }

  void setProfiles(Profile profile) {
    emit(state.copyWith(profiles: List.from(state.profiles)..add(profile)));
  }

  Future<void> initProfiles() async {
    emit(state.copyWith(profiles: [], isLoading: false));
  }

  void updatePosition(DragUpdateDetails details) {
    emit(state.copyWith(position: state.position + details.delta));
    final xCardPosition = state.position.dx;
    emit(state.copyWith(angle: 45 * xCardPosition / state.screensize.width));
  }

  CardStatus? endPosition() {
    emit(state.copyWith(isDragging: false));

    final status = _getStatus();
    if (status != null) {}

    switch (status) {
      case CardStatus.like:
        _like();
      case CardStatus.dislike:
        _dislike();
      case CardStatus.superLike:
        _superLike();
      default:
        _resetPosition();
    }
    return status;
  }

  CardStatus? _getStatus() {
    final xCardPosition = state.position.dx;
    final yCardPosition = state.position.dy;
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
    return null;
  }

  void _like() => emit(state.copyWith(
      angle: 20, position: Offset(2 * state.screensize.width / 2, 0)));

  void _dislike() => emit(state.copyWith(
      angle: -20, position: Offset(state.screensize.width / 2, 0)));

  void _superLike() => emit(
      state.copyWith(angle: 0, position: Offset(0, state.screensize.height)));

  void _resetPosition() =>
      emit(state.copyWith(isDragging: false, angle: 0, position: Offset.zero));
}

enum CardStatus { like, dislike, superLike }
