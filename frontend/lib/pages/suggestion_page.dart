import 'package:flutter/material.dart';
import 'package:frontend/pages/kinder_card.dart';
import 'package:frontend/provider/card_provider.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(child: Container(child: buildCards())));

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;
    return Stack(
      children: urlImages
          .map((image) =>
              ProfileCard(urlImage: image, isFront: urlImages.last == image))
          .toList(),
    );
  }
}
