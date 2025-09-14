import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/state/card/card_cubit.dart';
import 'package:frontend/state/card/card_state.dart';

class KinderCardStyling extends StatelessWidget {
  const KinderCardStyling({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocSelector<CardCubit, CardState, Profile>(
        selector: (state) => state.profile,
        builder: (context, profile) {
          return Container(
            foregroundDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: theme.colorScheme.primary, width: 3)),
            decoration: ShapeDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    profile.imageUrls.first,
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface
                      .withValues(alpha: 0.5),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profile.name}, ${profile.age}',
                      style: theme.textTheme.displayMedium,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${profile.job}, ",
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).works_at,
                            style: theme.textTheme.displaySmall,
                          ),
                          TextSpan(
                            text: ' At ${profile.job}',
                            style: theme.textTheme.displaySmall?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
