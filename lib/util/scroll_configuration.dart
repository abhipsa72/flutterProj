import 'dart:io';

import 'package:flutter/material.dart';

/// The scroll physics to use for the platform given by [getPlatform].
///
/// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
/// Android.
ScrollPhysics getScrollPhysics(BuildContext context) {
  switch (getPlatform(context)) {
    case TargetPlatform.iOS:
      return const BouncingScrollPhysics();
    case TargetPlatform.android:
      return const ClampingScrollPhysics();
  }
  return null;
}

getPlatform(BuildContext context) {
  return Platform;
}
