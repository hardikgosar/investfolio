import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/portfolio_entity.dart';

class PerformanceChart extends StatelessWidget {
  final List<PerformancePoint> points;

  const PerformanceChart({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return const SizedBox.shrink();
    }

    final minValue = points
        .map((point) => point.value)
        .reduce((a, b) => a < b ? a : b);

    final maxValue = points
        .map((point) => point.value)
        .reduce((a, b) => a > b ? a : b);

    final range = (maxValue - minValue).abs();

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio performance',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 4),

          Text(
            'Last 7 days',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AppSpacing.md),

          SizedBox(
            height: 190,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (points.length - 1).toDouble(),

                minY: minValue -
                    (range == 0 ? 1000 : range * 0.18),

                maxY: maxValue +
                    (range == 0 ? 1000 : range * 0.18),

                gridData: const FlGridData(
                  show: false,
                ),

                borderData: FlBorderData(
                  show: false,
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,

                      // Important: show only one label per point.
                      interval: 1,

                      reservedSize: 24,

                      getTitlesWidget: (value, meta) {
                        final index = value.round();

                        // Ignore non-integer positions.
                        if (value != index.toDouble()) {
                          return const SizedBox.shrink();
                        }

                        // Prevent invalid indexes.
                        if (index < 0 || index >= points.length) {
                          return const SizedBox.shrink();
                        }

                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            points[index].label,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) {
                      return spots.map(
                        (spot) {
                          return LineTooltipItem(
                            '₹${spot.y.toStringAsFixed(0)}',
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ).toList();
                    },
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      points.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        points[index].value,
                      ),
                    ),

                    isCurved: true,

                    barWidth: 3,

                    color: AppColors.accent,

                    dotData: const FlDotData(
                      show: false,
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.accentSoft,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}