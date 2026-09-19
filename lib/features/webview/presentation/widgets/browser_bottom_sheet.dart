import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/browser_bloc.dart';
import 'custom_browser_view.dart';

/// Public entry point: "on click of a button/link, a bottom drawer
/// appears" showing the custom in-app browser loading [url].
///
/// A fresh [BrowserBloc] is scoped to the sheet's lifetime — closing
/// the sheet disposes it, so re-opening always starts clean.
Future<void> showBrowserBottomSheet(
  BuildContext context, {
  required String url,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (sheetContext) {
      return FractionallySizedBox(
        heightFactor: 0.92,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
          child: Material(
            color: Theme.of(sheetContext).scaffoldBackgroundColor,
            child: BlocProvider(
              create: (_) => BrowserBloc(),
              child: CustomBrowserView(
                initialUrl: url,
              ),
            ),
          ),
        ),
      );
    },
  );
}