import 'package:equatable/equatable.dart';
import '../../domain/entities/explore_link_entity.dart';

enum ExploreStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  final ExploreStatus status;
  final List<ExploreLinkEntity> links;
  final ExploreLinkEntity? activeLink; // link whose bottom sheet is open
  final String? errorMessage;

  const ExploreState({
    this.status = ExploreStatus.initial,
    this.links = const [],
    this.activeLink,
    this.errorMessage,
  });

  ExploreState copyWith({
    ExploreStatus? status,
    List<ExploreLinkEntity>? links,
    ExploreLinkEntity? activeLink,
    bool clearActiveLink = false,
    String? errorMessage,
  }) {
    return ExploreState(
      status: status ?? this.status,
      links: links ?? this.links,
      activeLink: clearActiveLink ? null : (activeLink ?? this.activeLink),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, links, activeLink, errorMessage];
}
