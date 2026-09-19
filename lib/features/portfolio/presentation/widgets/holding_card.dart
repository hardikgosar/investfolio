import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/holding_entity.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';

class HoldingCard extends StatelessWidget {
  final HoldingEntity holding;
  final bool isSelected;

  const HoldingCard({
    super.key,
    required this.holding,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isProfit = holding.isProfit;

    return AnimatedContainer(
      duration: AppDurations.fast,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isSelected ? AppColors.accent : AppColors.divider,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => context.read<PortfolioBloc>().add(
          PortfolioHoldingSelected(holding.id),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.accentSoft,
                    child: Text(
                      holding.symbol.substring(0, 2),
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          holding.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${holding.symbol} · ${holding.assetType} · ${holding.units.toStringAsFixed(1)} units',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${holding.currentValue.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${isProfit ? '+' : ''}₹${holding.returnsAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: isProfit
                              ? AppColors.profitGreen
                              : AppColors.lossRed,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isSelected) ...[
                const Divider(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _DetailStat(
                      label: 'Avg. buy',
                      value: '₹${holding.averageBuyPrice.toStringAsFixed(2)}',
                    ),
                    _DetailStat(
                      label: 'Price',
                      value: '₹${holding.currentPrice.toStringAsFixed(2)}',
                    ),
                    _DetailStat(
                      label: 'Day',
                      value:
                          '${holding.dayChangePercent >= 0 ? '+' : ''}${holding.dayChangePercent.toStringAsFixed(2)}%',
                      valueColor: holding.dayChangePercent >= 0
                          ? AppColors.profitGreen
                          : AppColors.lossRed,
                    ),
                    _DetailStat(
                      label: 'Returns',
                      value: '${holding.returnsPercent.toStringAsFixed(2)}%',
                      valueColor: isProfit
                          ? AppColors.profitGreen
                          : AppColors.lossRed,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
