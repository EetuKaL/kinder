import 'dart:ui';

import 'package:frontend/models/profile.dart';

class CardState {
  final Profile profile;
  final bool isDragging;
  final Offset position;
  final Size screensize;
  final double angle;
  final bool isLoading;

  CardState({
    required this.profile,
    this.isDragging = false,
    this.position = Offset.zero,
    this.screensize = Size.zero,
    this.angle = 0,
    this.isLoading = true,
  });

  CardState copyWith({
    Profile? profile,
    bool? isDragging,
    Offset? position,
    Size? screensize,
    double? angle,
    bool? isLoading,
  }) {
    return CardState(
      profile: profile ?? this.profile,
      isDragging: isDragging ?? this.isDragging,
      position: position ?? this.position,
      screensize: screensize ?? this.screensize,
      angle: angle ?? this.angle,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
