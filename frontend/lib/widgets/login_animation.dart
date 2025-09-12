import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/utils/kinder_responsiveness.dart';
import 'package:lottie/lottie.dart';

class LoginAnimation extends StatelessWidget {
  const LoginAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final responsive = KinderResponsiveness.of(context);
    return Stack(
      children: [
        Lottie.asset('assets/animation_login.json',
            fit: BoxFit.contain, frameRate: FrameRate(30), reverse: true),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(responsive.borderRadius),
            ),
            child: Padding(
              padding: responsive.paddingLoose,
              child: Text(
                s.welcome_to_kinder,
                style: responsive.textStyle.headline.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
