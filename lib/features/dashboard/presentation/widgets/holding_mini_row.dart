import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../portfolio/domain/entities/holding_entity.dart';

class HoldingMiniRow extends StatelessWidget {
  final HoldingEntity holding;
  const HoldingMiniRow({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    final isProfit = holding.isProfit;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.accentSoft,
            child: Text(
              holding.symbol.substring(0, 2),
              style: const TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(holding.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis),
                Text(holding.symbol,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${holding.currentValue.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${isProfit ? '+' : ''}${holding.returnsPercent.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: isProfit ? AppColors.profitGreen : AppColors.lossRed,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
