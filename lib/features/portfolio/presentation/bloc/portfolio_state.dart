import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/entities/holding_entity.dart';

enum PortfolioStatus { initial, loading, success, failure }

class PortfolioState extends Equatable {
  final PortfolioStatus status;
  final PortfolioEntity? portfolio;
  final String? selectedHoldingId;
  final String? errorMessage;
  const PortfolioState({
    this.status = PortfolioStatus.initial,
    this.portfolio,
    this.selectedHoldingId,
    this.errorMessage,
  });
  List<HoldingEntity> get holdings => portfolio?.holdings ?? const [];
  double get totalInvested => portfolio?.investedValue ?? 0;
  double get totalCurrentValue => portfolio?.currentValue ?? 0;
  double get totalPortfolioValue => portfolio?.totalValue ?? 0;
  double get totalReturns => portfolio?.returns ?? 0;
  double get totalReturnsPercent => portfolio?.returnsPercent ?? 0;
  double get cashBalance => portfolio?.cashBalance ?? 0;
  double get dayChange => portfolio?.dayChange ?? 0;
  double get dayChangePercent => portfolio?.dayChangePercent ?? 0;
  List<PerformancePoint> get performance => portfolio?.performance ?? const [];
  List<TransactionEntity> get transactions =>
      portfolio?.transactions ?? const [];

  PortfolioState copyWith({
    PortfolioStatus? status,
    PortfolioEntity? portfolio,
    String? selectedHoldingId,
    String? errorMessage,
    bool clearSelection = false,
    bool clearError = false,
  }) => PortfolioState(
    status: status ?? this.status,
    portfolio: portfolio ?? this.portfolio,
    selectedHoldingId: clearSelection
        ? null
        : (selectedHoldingId ?? this.selectedHoldingId),
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );
  @override
  List<Object?> get props => [
    status,
    portfolio,
    selectedHoldingId,
    errorMessage,
  ];
}
