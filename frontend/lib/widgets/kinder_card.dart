import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/kinder_card_styling.dart';

import 'package:provider/provider.dart';

class KinderCard extends StatefulWidget {
  final Profile profile;
  final bool isTop;
  const KinderCard({super.key, required this.profile, required this.isTop});

  @override
  State<KinderCard> createState() => _KinderCardState();
}

class _KinderCardState extends State<KinderCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.sizeOf(context);

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTop ? buildFirstCard() : buildCard();
  }

  Widget buildFirstCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final card = context.watch<CardProvider>();
            final position = card.position;
            final milliseconds = card.isDragging ? 0 : 400;

            // Define rotate of image.

            final center = constraints.smallest.center(Offset.zero);
            final angle = card.angle * pi / 180;

            final RotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              transform: RotatedMatrix..translate(position.dx, position.dy),
              duration: Duration(milliseconds: milliseconds),
              child: buildCard(),
            );
          },
        ),
        onPanStart: (details) =>
            context.read<CardProvider>().startPosition(details),
        onPanUpdate: (details) =>
            context.read<CardProvider>().updatePosition(details),
        onPanEnd: (details) => context.read<CardProvider>().endPosition(),
      );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: KinderCardStyling(
        image: widget.profile.imageUrls[0],
        name: widget.profile.name,
        age: widget.profile.age,
        job: widget.profile.job,
        jobAt: widget.profile.jobAt,
      ));
}
