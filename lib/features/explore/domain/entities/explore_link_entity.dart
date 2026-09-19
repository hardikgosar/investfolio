import 'package:equatable/equatable.dart';

/// Represents a single external resource shown on the Explore screen.
/// Tapping its card opens the bottom sheet -> custom in-app browser.
class ExploreLinkEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String url;
  final String iconLabel; // short label used to render a simple avatar

  const ExploreLinkEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.iconLabel,
  });

  @override
  List<Object?> get props => [id, title, subtitle, url, iconLabel];
}
