import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/app_scale.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/profile_card.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  late List<Widget> cardList = [];
  List<Profile> profileList = [];
  late Future<List<Profile>> _getprofiles;
  double heartSize = 30;
  var fetchedData;
  var cardPosition;

  void _removeCard() {
    setState(() {
      cardList.removeAt(cardList.length - 1);
    });
  }

  Future<List<Profile>> getProfiles() async {
    // Change to fetch data from api when backend is ready.
    final String response =
        await rootBundle.loadString('assets/mock_data.json');
    final data = await json.decode(response);
    await Future.delayed(Duration(seconds: 3), () async {
      // Do something
    });
    for (var user in data) {
      Profile profile = Profile.fromJson(user);
      profileList.add(profile);
    }

    return profileList;

// ...
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedData = false;
    _getprofiles = getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: _getprofiles,
            builder: (ctx, snapshot) {
              // Checking if future is resolved
              if (snapshot.connectionState == ConnectionState.done) {
                // If we got an error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  // Extracting data from snapshot object
                  final data = snapshot.data;
                  if (cardList.isEmpty && !fetchedData) {
                    cardList = getProfileCards(data);
                    fetchedData = true;
                  } else if (cardList.isEmpty && fetchedData) {
                    return Center(
                        child: Container(
                            width: _scale.cardWidth,
                            height: _scale.cardHeight,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/animation_clap.json',
                                    width: _scale.cardWidth / 3,
                                    height: _scale.cardHeight / 3,
                                    fit: BoxFit.fill,
                                    frameRate: FrameRate(30)),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Onnittelut,\n olet taas lähempänä löytää onnesi!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF4E4B6F),
                                      fontSize: 26,
                                      fontFamily: 'Montagu Slab',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: -0.48,
                                    ),
                                  ),
                                )
                              ],
                            )));
                  }

                  return Expanded(
                      child: Stack(
                          alignment: Alignment.centerLeft, children: cardList));
                } else {
                  return Container(
                      width: _scale.cardWidth,
                      height: _scale.cardHeight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 150, bottom: 100, left: 50, right: 50),
                        child: const CircularProgressIndicator(),
                      ));
                }
              } else {
                return Container(
                    width: _scale.cardWidth,
                    height: _scale.cardHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 150, bottom: 100, left: 50, right: 50),
                      child: const CircularProgressIndicator(),
                    ));
              }
            },
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageIcon(AssetImage('assets/cancel.png'),
                    size: 30, color: Color(0xFF4E4B6F)),
                ImageIcon(
                  AssetImage('assets/like.png'),
                  size: heartSize,
                  color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Returns list of draggable profilecards.
  List<Widget> getProfileCards(data) {
    List<Widget> profileCards = [];
    double index = 1;
    // For every profile make a draggable profile card.
    for (var element in data) {
      index++;
      profileCards.add(
        Positioned(
          left: 4 * index,
          top: index,
          child: Draggable(
            axis: Axis.horizontal,
            onDragStarted: () {},
            onDragEnd: (drag) {
              print(drag.offset.dx);
              if (drag.offset.dx < -50) {
                print('Swiped left');
              } else if (drag.offset.dx > 50) {
                print('swiped Right');
                setState(() {
                  _removeCard();
                });
              } else {}
            },
            onDragUpdate: (details) {},
            feedback: Profile_Card(
              image: element.imageUrls,
              age: element.profileAge,
              name: element.profileName,
              job: element.profileJob,
              jobAt: element.profileJobAt,
            ),
            child: Profile_Card(
              image: element.imageUrls,
              age: element.profileAge,
              name: element.profileName,
              job: element.profileJob,
              jobAt: element.profileJobAt,
            ),
            childWhenDragging: Container(),
          ),
        ),
      );
    }

    return profileCards;
  }
}
