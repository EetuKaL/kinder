import 'package:flutter/material.dart';
import 'package:frontend/components/app_scale.dart';

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
    // TODO: implement initState
    super.initState();
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
              child: buildCards()),
        )));
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;
    return Stack(
      children: urlImages
          .map((image) =>
              KinderCard(urlImage: image, isFront: urlImages.last == image))
          .toList(),
    );
  }
}
