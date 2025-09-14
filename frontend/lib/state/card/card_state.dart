import 'dart:ui';

import 'package:frontend/models/profile.dart';

class CardState {
  final List<Profile> profiles;
  final bool isDragging;
  final Offset position;
  final Size screensize;
  final double angle;
  final bool isLoading;

  CardState({
    this.profiles = const [],
    this.isDragging = false,
    this.position = Offset.zero,
    this.screensize = Size.zero,
    this.angle = 0,
    this.isLoading = true,
  });

  CardState copyWith({
    List<Profile>? profiles,
    bool? isDragging,
    Offset? position,
    Size? screensize,
    double? angle,
    bool? isLoading,
  }) {
    return CardState(
      profiles: profiles ?? this.profiles,
      isDragging: isDragging ?? this.isDragging,
      position: position ?? this.position,
      screensize: screensize ?? this.screensize,
      angle: angle ?? this.angle,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
