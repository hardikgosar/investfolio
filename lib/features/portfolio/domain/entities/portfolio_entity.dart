import 'package:equatable/equatable.dart';
import 'holding_entity.dart';

class PerformancePoint extends Equatable {
  final String label;
  final double value;
  const PerformancePoint({required this.label, required this.value});
  @override
  List<Object?> get props => [label, value];
}

class TransactionEntity extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String type;
  final double quantity;
  final double price;
  final double amount;
  final DateTime date;

  const TransactionEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.type,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.date,
  });
  bool get isBuy => type.toUpperCase() == 'BUY';
  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    type,
    quantity,
    price,
    amount,
    date,
  ];
}

class PortfolioEntity extends Equatable {
  final String portfolioId;
  final String currency;
  final double cashBalance;
  final double dayChange;
  final double dayChangePercent;
  final List<HoldingEntity> holdings;
  final List<PerformancePoint> performance;
  final List<TransactionEntity> transactions;

  const PortfolioEntity({
    required this.portfolioId,
    required this.currency,
    required this.cashBalance,
    required this.dayChange,
    required this.dayChangePercent,
    required this.holdings,
    required this.performance,
    required this.transactions,
  });
  double get investedValue => holdings.fold(0, (s, h) => s + h.investedAmount);
  double get currentValue => holdings.fold(0, (s, h) => s + h.currentValue);
  double get totalValue => currentValue + cashBalance;
  double get returns => currentValue - investedValue;
  double get returnsPercent =>
      investedValue == 0 ? 0 : returns / investedValue * 100;
  @override
  List<Object?> get props => [
    portfolioId,
    currency,
    cashBalance,
    dayChange,
    dayChangePercent,
    holdings,
    performance,
    transactions,
  ];
}
