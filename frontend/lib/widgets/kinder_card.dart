import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/profile_card.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class KinderCard extends StatefulWidget {
  String urlImage;
  bool isFront;
  KinderCard({super.key, required this.urlImage, required this.isFront});

  @override
  State<KinderCard> createState() => _KinderCardState();
}

class _KinderCardState extends State<KinderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) =>
      SizedBox.expand(child: widget.isFront ? buildFirstCard() : buildCard());

  Widget buildFirstCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;

            // Define rotate of image.
            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final RotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              transform: RotatedMatrix..translate(position.dx, position.dy),
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              child: buildCard(),
            );
          },
        ),
        // Saving in the provider's state different positions of profilecard.
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.endPosition();
        },
      );

  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.urlImage),
              fit: BoxFit.cover,
              alignment: Alignment(-0.3, 0),
            ),
          ),
        ),
      );
}
