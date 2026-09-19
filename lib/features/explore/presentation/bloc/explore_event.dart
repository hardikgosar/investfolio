import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
  @override
  List<Object?> get props => [];
}

class ExploreFetchRequested extends ExploreEvent {
  const ExploreFetchRequested();
}

/// Fired when the user taps a link card — triggers the bottom sheet.
class ExploreLinkTapped extends ExploreEvent {
  final String linkId;
  const ExploreLinkTapped(this.linkId);

  @override
  List<Object?> get props => [linkId];
}

/// Fired when the bottom sheet is dismissed (reset "active" selection).
class ExploreSheetDismissed extends ExploreEvent {
  const ExploreSheetDismissed();
}
