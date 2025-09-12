import 'package:flutter/material.dart';

import 'package:frontend/generated/l10n.dart';

class KinderCardStyling extends StatelessWidget {
  final String? name;
  final int? age;
  final String? job;
  final String? jobAt;
  final String image;

  const KinderCardStyling({
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
    return Container(
      foregroundDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: theme.colorScheme.primary, width: 3)),
      decoration: ShapeDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
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
                '$name, $age',
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.left,
              ),
              Text(
                "$job, ",
                style: theme.textTheme.displaySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: S.of(context).works_at,
                      style: theme.textTheme.displaySmall,
                    ),
                    TextSpan(
                      text: ' $jobAt',
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
  }
}
