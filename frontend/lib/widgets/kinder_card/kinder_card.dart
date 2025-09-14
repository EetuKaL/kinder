import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/state/card/card_cubit.dart';
import 'package:frontend/state/card/card_state.dart';
import 'package:frontend/utils/snackbar.dart';
import 'package:frontend/widgets/kinder_card/kinder_card_styling.dart';

class KinderCard extends StatelessWidget {
  final Profile profile;
  final bool isTop;
  const KinderCard({super.key, required this.profile, required this.isTop});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocProvider(
        create: (context) =>
            CardCubit(profile: profile, screenSize: screenSize),
        child: isTop ? buildCardWithSwipeFeature() : buildCard());
  }

  void _showUserChoice(BuildContext context, CardStatus? choice) {
    final s = S.of(context);
    switch (choice) {
      case CardStatus.like:
        showSwipeStatus(context, s.liked);
      case CardStatus.dislike:
        showSwipeStatus(context, s.disliked);
      case CardStatus.superLike:
        showSwipeStatus(context, s.super_liked);
      default:
        break;
    }
  }

  Widget buildCardWithSwipeFeature() => BlocBuilder<CardCubit, CardState>(
        builder: (context, cardState) {
          final onPanStart = context.read<CardCubit>().startPosition;
          final onPanUpdate = context.read<CardCubit>().updatePosition;
          final onPanEnd = context.read<CardCubit>().endPosition;
          return GestureDetector(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final position = cardState.position;
                final milliseconds = cardState.isDragging ? 0 : 400;

                final center = constraints.smallest.center(Offset.zero);
                final angle = cardState.angle * pi / 180;

                final rotatedMatrix = Matrix4.identity()
                  ..translate(
                    center.dx,
                    center.dy,
                    0,
                  )
                  ..rotateZ(angle)
                  ..translate(
                    -center.dx,
                    -center.dy,
                    0,
                  );

                return AnimatedContainer(
                  transform: rotatedMatrix
                    ..translate(
                      position.dx,
                      position.dy,
                      0,
                    ),
                  duration: Duration(milliseconds: milliseconds),
                  child: buildCard(),
                );
              },
            ),
            onPanStart: (details) => onPanStart(details),
            onPanUpdate: (details) => onPanUpdate(details),
            onPanEnd: (details) {
              final userChoice = onPanEnd();
              _showUserChoice(context, userChoice);
            },
          );
        },
      );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: const KinderCardStyling());
}
