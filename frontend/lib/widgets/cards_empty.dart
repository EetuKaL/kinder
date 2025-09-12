import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/utils/kinder_responsiveness.dart';
import 'package:lottie/lottie.dart';

class CardsEmpty extends StatelessWidget {
  const CardsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final kR = KinderResponsiveness.of(context);
    return Column(
      spacing: kR.spacingLoose,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.congratulations,
            textAlign: TextAlign.center, style: kR.textStyle.display),
        Text(s.closer_to_happiness,
            textWidthBasis: TextWidthBasis.longestLine,
            textAlign: TextAlign.center,
            style: kR.textStyle.body),
        Lottie.asset('assets/animation_clap.json',
            fit: BoxFit.contain, frameRate: FrameRate(30)),
      ],
    );
  }
}
