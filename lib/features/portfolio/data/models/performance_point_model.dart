import '../../domain/entities/portfolio_entity.dart';

class PerformancePointModel {
  final String label;
  final double value;

  const PerformancePointModel({required this.label, required this.value});

  factory PerformancePointModel.fromJson(Map<String, dynamic> json) =>
      PerformancePointModel(
        label: json['label'] as String? ?? '',
        value: (json['value'] as num? ?? 0).toDouble(),
      );

  PerformancePoint toEntity() =>
      PerformancePoint(label: label, value: value);
}
