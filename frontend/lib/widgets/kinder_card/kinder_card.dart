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
    const card = KinderCardStyling();
    return isTop ? _makeItSwipable(card) : card;
  }

  void _showUserChoice(BuildContext context, CardStatus? choice) {
    final s = S.of(context);
    switch (choice) {
      case CardStatus.like:
        showSwipeStatus(context, s.liked);
      case CardStatus.dislike:
        showSwipeStatus(context, s.disliked);
      case CardStatus.superLike:
        showSwipeStatus(context, s.superLiked);
      default:
        break;
    }
  }

  Widget _makeItSwipable(KinderCardStyling card) => BlocProvider(
        create: (context) =>
            CardCubit(profile: profile, screenSize: context.size!),
        child: BlocBuilder<CardCubit, CardState>(
          builder: (context, cardState) {
            return GestureDetector(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final position = cardState.position;

                  final center = constraints.smallest.center(Offset.zero);
                  final angle = cardState.angle * pi / 180;

                  final rotatedMatrix = Matrix4.identity()
                    ..translateByDouble(center.dx, center.dy, 0, 0)
                    ..rotateZ(angle)
                    ..translateByDouble(-center.dx, -center.dy, 0, 0);

                  return AnimatedContainer(
                    transform: rotatedMatrix
                      ..translateByDouble(position.dx, position.dy, 0, 0),
                    duration: const Duration(milliseconds: 400),
                    child: card,
                  );
                },
              ),
              onPanStart: (details) =>
                  context.read<CardCubit>().startPosition(details),
              onPanUpdate: (details) =>
                  context.read<CardCubit>().updatePosition(details),
              onPanEnd: (details) => _showUserChoice(
                  context, context.read<CardCubit>().endPosition()),
            );
          },
        ),
      );
}
