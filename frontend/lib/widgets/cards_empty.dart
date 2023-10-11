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
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Onnittelut!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayLarge),
                      Lottie.asset('assets/animation_clap.json',
                          width: _scale.cardWidth / 4,
                          height: _scale.cardHeight / 5,
                          fit: BoxFit.fill,
                          frameRate: FrameRate(30)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Text('Olet taas lähempänä löytää onnesi :)',
                      textWidthBasis: TextWidthBasis.longestLine,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.displayMedium),
                ),
              ],
            )));
  }
}
