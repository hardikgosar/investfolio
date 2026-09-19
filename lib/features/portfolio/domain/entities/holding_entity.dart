import 'package:equatable/equatable.dart';

class HoldingEntity extends Equatable {
  final String id, name, symbol, sector, assetType;
  final double investedAmount,
      currentValue,
      units,
      averageBuyPrice,
      currentPrice,
      dayChange,
      dayChangePercent;
  const HoldingEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.investedAmount,
    required this.currentValue,
    required this.units,
    required this.averageBuyPrice,
    required this.currentPrice,
    required this.dayChange,
    required this.dayChangePercent,
    required this.sector,
    required this.assetType,
  });
  double get returnsAmount => currentValue - investedAmount;
  double get returnsPercent =>
      investedAmount == 0 ? 0 : returnsAmount / investedAmount * 100;
  bool get isProfit => returnsAmount >= 0;
  @override
  List<Object?> get props => [
    id,
    name,
    symbol,
    investedAmount,
    currentValue,
    units,
    averageBuyPrice,
    currentPrice,
    dayChange,
    dayChangePercent,
    sector,
    assetType,
  ];
}
