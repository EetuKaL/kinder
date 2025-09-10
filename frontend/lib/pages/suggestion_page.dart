import 'package:flutter/material.dart';
import 'package:kinderfrontend/models/profile.dart';
import 'package:kinderfrontend/provider/card_provider.dart';
import 'package:kinderfrontend/widgets/cards_empty.dart';
import 'package:kinderfrontend/widgets/custom_appbar.dart';
import 'package:kinderfrontend/widgets/kinder_card.dart';
import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
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
    final theme = Theme.of(context);
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
                  return !cardProvider.isLoading
                      ? buildCards(cardProvider.profiles)
                      : Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
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

  Widget buildCards(List<Profile> profiles) {
    return profiles.isNotEmpty
        ? Stack(
            children: profiles.map((profile) {
              return KinderCard(
                  profile: profile, isTop: profiles.last == profile);
            }).toList(),
          )
        : const CardsEmpty();
  }
}
