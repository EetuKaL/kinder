import 'package:flutter/material.dart';

/// If listening loading and wants build to trigger on change then needed to provide the setState function:
///
/// example:
///
///   late final AsyncHandler asyncHandler;
///
///   @override
///
///   void initState() {
///
///     super.initState();
///     asyncHandler = AsyncHandler(setState: setState);
///
///   }
///
class AsyncHandler {
  late final void Function(void Function())? _setState;
  bool loading = false;

  AsyncHandler({void Function(void Function() fn)? setState}) {
    _setState = setState;
  }

  Future<void> tryCall<T>(BuildContext context, Future<void> Function() action,
      Function(T) onException) async {
    if (_setState != null) {
      _setState!(() {
        loading = true;
      });
    }
    try {
      await Future.delayed(const Duration(seconds: 1));
      await action();
    } catch (e) {
      if (e is T) {
        onException(e as T);
      }
    }

    if (_setState != null && context.mounted) {
      _setState!(() {
        loading = false;
      });
    }
  }
}
