import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/portfolio_entity.dart';

class TransactionsCard extends StatelessWidget {
  final List<TransactionEntity> transactions;
  const TransactionsCard({super.key, required this.transactions});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      border: Border.all(color: AppColors.divider),
    ),
    child: Column(
      children: [
        for (int i = 0; i < transactions.length; i++) ...[
          if (i > 0) const Divider(height: AppSpacing.lg),
          _TransactionRow(item: transactions[i]),
        ],
      ],
    ),
  );
}

class _TransactionRow extends StatelessWidget {
  final TransactionEntity item;
  const _TransactionRow({required this.item});
  @override
  Widget build(BuildContext context) {
    final buy = item.isBuy;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: buy ? AppColors.accentSoft : const Color(0xFFFFF0EE),
            shape: BoxShape.circle,
          ),
          child: Icon(
            buy ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
            color: buy ? AppColors.accent : AppColors.lossRed,
            size: 18,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.symbol,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                '${buy ? 'Bought' : 'Sold'} ${item.quantity.toStringAsFixed(1)} units',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${item.amount.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              '${item.date.day}/${item.date.month}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
