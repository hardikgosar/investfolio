import 'package:equatable/equatable.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the Portfolio screen first mounts, or on pull-to-refresh.
class PortfolioFetchRequested extends PortfolioEvent {
  const PortfolioFetchRequested();
}

/// Fired when the user taps a holding card to expand/select it.
class PortfolioHoldingSelected extends PortfolioEvent {
  final String holdingId;
  const PortfolioHoldingSelected(this.holdingId);

  @override
  List<Object?> get props => [holdingId];
}
