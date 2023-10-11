import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/cards_empty.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/kinder_card.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CardProvider>(context, listen: false).initProfiles();
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    final theme = Theme.of(context);
    AppScale _scale = AppScale(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppbar(),
        body: SafeArea(
            child: Center(
          child: SizedBox(
              height: _scale.cardHeight,
              width: _scale.cardWidth,
              child: Consumer<CardProvider>(builder: (context, value, child) {
                return !provider.isLoading
                    ? buildCards(value.profiles)
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 150, bottom: 150),
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                          strokeWidth: 10,
                        ),
                      );
              })),
        )));
  }

  Widget buildCards(profiles) {
    final List<Profile> profilesMap = profiles;

    return profiles.length > 0
        ? Stack(
            children: profilesMap.map((profile) {
              return KinderCard(
                  profile: profile, isFront: profilesMap.last == profile);
            }).toList(),
          )
        : const CardsEmpty();
  }
}
