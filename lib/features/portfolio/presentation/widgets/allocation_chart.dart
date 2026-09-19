import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/holding_entity.dart';

class AllocationChart extends StatelessWidget {
  final List<HoldingEntity> holdings;
  const AllocationChart({super.key, required this.holdings});

  static const List<Color> _palette = [
    AppColors.accent,
    AppColors.profitGreen,
    AppColors.warningAmber,
    Color(0xFF9C6BFF),
    Color(0xFF3FB6D3),
  ];

  @override
  Widget build(BuildContext context) {
    final total = holdings.fold<double>(0, (s, h) => s + h.currentValue);
    if (total == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 32,
                sections: List.generate(holdings.length, (i) {
                  final h = holdings[i];
                  final pct = (h.currentValue / total) * 100;
                  return PieChartSectionData(
                    color: _palette[i % _palette.length],
                    value: h.currentValue,
                    title: '${pct.toStringAsFixed(0)}%',
                    radius: 22,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(holdings.length, (i) {
                final h = holdings[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _palette[i % _palette.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          h.symbol,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
