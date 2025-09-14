import 'package:flutter/material.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/repositories/suggestion_repository.dart';
import 'package:frontend/widgets/cards_empty.dart';
import 'package:frontend/widgets/centered_circular_progress_indicator.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/kinder_card/kinder_card.dart';
import 'package:provider/provider.dart';

class SuggestionPage extends StatelessWidget {
  static const String routeName = '/';
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: StreamBuilder<Iterable<Profile>>(
                stream: context.read<SuggestionRepository>().suggestionStream,
                builder: (context, snapshot) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: !snapshot.hasData
                        ? const CenteredCircularProgressIndicator()
                        : snapshot.data!.isEmpty
                            ? const CardsEmpty()
                            : Stack(
                                children: snapshot.data!.indexed
                                    .map<KinderCard>(
                                      (tuple) => KinderCard(
                                        profile: tuple.$2,
                                        isTop: tuple.$1 ==
                                            snapshot.data!.length - 1,
                                      ),
                                    )
                                    .toList(),
                              ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
