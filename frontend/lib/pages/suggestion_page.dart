import 'package:flutter/material.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/cards_empty.dart';
import 'package:frontend/widgets/centered_circular_progress_indicator.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/kinder_card.dart';

import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
  static const String routeName = '/';
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CardProvider>().initProfiles();
    });
  }

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
              child: Consumer<CardProvider>(
                builder: (context, cardProvider, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: cardProvider.isLoading
                        ? const CenteredCircularProgressIndicator()
                        : cardProvider.profiles.isEmpty
                            ? const CardsEmpty()
                            : Stack(
                                children: cardProvider.profiles.indexed
                                    .map<KinderCard>(
                                      (tuple) => KinderCard(
                                        profile: tuple.$2,
                                        isTop: tuple.$1 ==
                                            cardProvider.profiles.length - 1,
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
