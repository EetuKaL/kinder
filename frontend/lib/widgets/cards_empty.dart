import 'package:flutter/material.dart';
import 'package:kinderfrontend/generated/l10n.dart';
import 'package:lottie/lottie.dart';

class CardsEmpty extends StatelessWidget {
  const CardsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Center(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation_clap.json',
                    fit: BoxFit.contain, frameRate: FrameRate(30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 0),
                      child: Text(s.congratulations,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.displayLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(s.closer_to_happiness,
                          textWidthBasis: TextWidthBasis.longestLine,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.displayMedium),
                    ),
                  ],
                )
              ],
            )));
  }
}
