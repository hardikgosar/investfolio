import '../../domain/entities/holding_entity.dart';

class HoldingModel {
  final String id;
  final String name;
  final String symbol;
  final double investedAmount;
  final double currentValue;
  final double units;
  final double averageBuyPrice;
  final double currentPrice;
  final double dayChange;
  final double dayChangePercent;
  final String sector;
  final String assetType;

  const HoldingModel({
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

  factory HoldingModel.fromJson(Map<String, dynamic> json) => HoldingModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        symbol: json['symbol'] as String? ?? '',
        investedAmount: (json['investedAmount'] as num? ?? 0).toDouble(),
        currentValue: (json['currentValue'] as num? ?? 0).toDouble(),
        units: (json['units'] as num? ?? 0).toDouble(),
        averageBuyPrice: (json['averageBuyPrice'] as num? ?? 0).toDouble(),
        currentPrice: (json['currentPrice'] as num? ?? 0).toDouble(),
        dayChange: (json['dayChange'] as num? ?? 0).toDouble(),
        dayChangePercent: (json['dayChangePercent'] as num? ?? 0).toDouble(),
        sector: json['sector'] as String? ?? '',
        assetType: json['assetType'] as String? ?? '',
      );

  HoldingEntity toEntity() => HoldingEntity(
        id: id,
        name: name,
        symbol: symbol,
        investedAmount: investedAmount,
        currentValue: currentValue,
        units: units,
        averageBuyPrice: averageBuyPrice,
        currentPrice: currentPrice,
        dayChange: dayChange,
        dayChangePercent: dayChangePercent,
        sector: sector,
        assetType: assetType,
      );
}
