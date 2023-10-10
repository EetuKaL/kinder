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
  var iteration = 0;
  var profiles;
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
    iteration++;
    AppScale _scale = AppScale(context);
    print('drawing next with data $profiles ${iteration}');

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
    print('buildcardissa profilen pituus on ${profiles.length}');
    /* for (var profile in profiles) {
      print(profile.name);
    } */
    final List<Profile> profilesMap = profiles;
    final provider = Provider.of<CardProvider>(context);
    /* final List<dynamic> profilesMap = profiles.map((e) {
      return {
        "id": e.id,
        "name": e.name,
        "job": e.job,
        "jobAt": e.jobAt,
        "imageUrls": e.imageUrls
      };
    }).toList(); */
    print('profilesmap on $profilesMap');
    return profiles.length > 0
        ? Stack(
            children: profilesMap.map((profile) {
              provider.setProfiles(profile);
              return KinderCard(
                  profile: profile, isFront: profilesMap.last == profile);
            }).toList(),
          )
        : Text('adssadasd');
  }
}
