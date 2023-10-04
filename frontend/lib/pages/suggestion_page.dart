import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:frontend/models/profile.dart';

import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/provider/data_provider.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/kinder_card.dart';
import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  late Future<List<Profile>> profiles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<DataProvider>(context);
    profiles = provider.getProfiles();
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
              child: FutureBuilder(
                future: profiles,
                builder: (context, snapshot) => buildCards(profiles),
              )),
        )));
  }

  Widget buildCards(profiles) {
    return Stack(
      children: profiles
          .map((profile) =>
              KinderCard(profile: profile, isFront: profiles.last == profile))
          .toList(),
    );
  }
}
