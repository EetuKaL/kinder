import 'package:flutter/material.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/state/card/card_cubit.dart';
import 'package:frontend/utils/others.dart';
import 'package:frontend/utils/snackbar.dart';
import 'package:frontend/widgets/cards_empty.dart';
import 'package:frontend/widgets/centered_circular_progress_indicator.dart';
import 'package:frontend/widgets/custom_appbar.dart';
import 'package:frontend/widgets/kinder_card/kinder_card.dart';

import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
  static const String routeName = '/';
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final List<Profile> _suggestedProfiles = [];
  late final AsyncHandler _asyncHandler;
  @override
  void initState() {
    super.initState();
    _asyncHandler = AsyncHandler(setState: setState);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _asyncHandler.tryCall(
          context,
          () => context.read<CardCubit>().initProfiles(),
          (e) => showErrorSnackBar(context, S.of(context).error_general));
    });
  }

/*   Future _nextCard() async {
    if (_profiles.isEmpty) return;
    // wait some time for the animation to finish.
    await Future.delayed(const Duration(milliseconds: 200));
    asyncHandler.tryCall(context, action, onException)
    _profiles.removeLast();
    resetPosition();
  } */

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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _asyncHandler.loading
                    ? const CenteredCircularProgressIndicator()
                    : _suggestedProfiles.isEmpty
                        ? const CardsEmpty()
                        : Stack(
                            children: _suggestedProfiles.indexed
                                .map<KinderCard>(
                                  (tuple) => KinderCard(
                                    profile: tuple.$2,
                                    isTop: tuple.$1 ==
                                        _suggestedProfiles.length - 1,
                                  ),
                                )
                                .toList(),
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
