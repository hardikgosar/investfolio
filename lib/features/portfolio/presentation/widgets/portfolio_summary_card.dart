import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/portfolio_state.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final PortfolioState state;
  const PortfolioSummaryCard({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    final profit = state.totalReturns >= 0;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current portfolio value',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 5),
          Text(
            '₹${state.totalPortfolioValue.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                profit
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                color: profit ? AppColors.profitGreen : Colors.redAccent,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                '${profit ? '+' : ''}₹${state.totalReturns.toStringAsFixed(0)}  (${state.totalReturnsPercent.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: profit ? AppColors.profitGreen : Colors.redAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                'Today ${state.dayChange >= 0 ? '+' : ''}₹${state.dayChange.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              _Metric('Invested', '₹${state.totalInvested.toStringAsFixed(0)}'),
              _Metric('Holdings', '${state.holdings.length}'),
              _Metric('Cash', '₹${state.cashBalance.toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label, value;
  const _Metric(this.label, this.value);
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}
