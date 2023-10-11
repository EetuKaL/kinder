import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'dart:math' as math;

class KinderCardStyling extends StatelessWidget {
  String? name;
  int? age;
  String? job;
  String? jobAt;
  String image;

  KinderCardStyling({
    super.key,
    this.age,
    this.job,
    this.name,
    this.jobAt,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    AppScale _scale = AppScale(context);
    return Container(
      height: _scale.cardHeight,
      width: _scale.cardWidth,
      alignment: const Alignment(0, -10),
      child: Container(
        height: _scale.cardHeight,
        width: _scale.cardWidth,
        alignment: Alignment.bottomRight,
        foregroundDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: theme.colorScheme.primary, width: 3)),
        decoration: ShapeDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                image,
                scale: 2,
              )),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          //Text box
          child: Container(
            height: _scale.cardHeight / 7,
            width: _scale.cardWidth * 0.9,
            decoration: ShapeDecoration(
              color: theme.colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$name, $age', style: theme.textTheme.displayMedium),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("$job, kohteessa $jobAt",
                      style: theme.textTheme.displaySmall),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}