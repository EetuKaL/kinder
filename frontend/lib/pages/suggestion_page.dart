import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/provider/card_provider.dart';
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
                print('value.profiles: ${value.profiles}');
                return buildCards(value.profiles);
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
        : Text('adssadasd');
  }
}
