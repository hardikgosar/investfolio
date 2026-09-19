import '../../domain/entities/portfolio_entity.dart';
import 'holding_model.dart';
import 'performance_point_model.dart';
import 'transaction_model.dart';

class PortfolioResponseModel {
  final String portfolioId;
  final String currency;
  final double cashBalance;
  final double dayChange;
  final double dayChangePercent;
  final List<HoldingModel> holdings;
  final List<PerformancePointModel> performance;
  final List<TransactionModel> transactions;

  const PortfolioResponseModel({
    required this.portfolioId,
    required this.currency,
    required this.cashBalance,
    required this.dayChange,
    required this.dayChangePercent,
    required this.holdings,
    required this.performance,
    required this.transactions,
  });

  factory PortfolioResponseModel.fromJson(Map<String, dynamic> json) {
    final rawHoldings = json['holdings'] as List<dynamic>? ?? const [];
    final rawPerformance = json['performance'] as List<dynamic>? ?? const [];
    final rawTransactions = json['transactions'] as List<dynamic>? ?? const [];

    return PortfolioResponseModel(
      portfolioId: json['portfolioId'] as String? ?? '',
      currency: json['currency'] as String? ?? 'INR',
      cashBalance: (json['cashBalance'] as num? ?? 0).toDouble(),
      dayChange: (json['dayChange'] as num? ?? 0).toDouble(),
      dayChangePercent: (json['dayChangePercent'] as num? ?? 0).toDouble(),
      holdings: rawHoldings
          .whereType<Map<String, dynamic>>()
          .map(HoldingModel.fromJson)
          .toList(growable: false),
      performance: rawPerformance
          .whereType<Map<String, dynamic>>()
          .map(PerformancePointModel.fromJson)
          .toList(growable: false),
      transactions: rawTransactions
          .whereType<Map<String, dynamic>>()
          .map(TransactionModel.fromJson)
          .toList(growable: false),
    );
  }

  PortfolioEntity toEntity() => PortfolioEntity(
        portfolioId: portfolioId,
        currency: currency,
        cashBalance: cashBalance,
        dayChange: dayChange,
        dayChangePercent: dayChangePercent,
        holdings: holdings.map((model) => model.toEntity()).toList(growable: false),
        performance:
            performance.map((model) => model.toEntity()).toList(growable: false),
        transactions:
            transactions.map((model) => model.toEntity()).toList(growable: false),
      );
}
