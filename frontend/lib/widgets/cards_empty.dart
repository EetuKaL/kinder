import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:lottie/lottie.dart';

class CardsEmpty extends StatelessWidget {
  const CardsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    AppScale _scale = AppScale(context);
    return Center(
        child: Container(
            width: _scale.cardWidth,
            height: _scale.cardHeight,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation_clap.json',
                    width: _scale.cardWidth / 2,
                    height: _scale.cardHeight / 2,
                    fit: BoxFit.contain,
                    frameRate: FrameRate(30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 0),
                      child: Text('Onnittelut!',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.displayLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text('Olet taas lähempänä löytää onnesi :)',
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
