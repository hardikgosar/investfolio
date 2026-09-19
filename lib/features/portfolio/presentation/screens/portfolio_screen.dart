import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_placeholders.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/allocation_chart.dart';
import '../widgets/holding_card.dart';
import '../widgets/performance_chart.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/transactions_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Portfolio')),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.status == PortfolioStatus.loading ||
              state.status == PortfolioStatus.initial)
            return const LoadingPlaceholder();
          if (state.status == PortfolioStatus.failure)
            return ErrorPlaceholder(
              message: state.errorMessage ?? 'Something went wrong',
              onRetry: () => context.read<PortfolioBloc>().add(
                const PortfolioFetchRequested(),
              ),
            );
          return RefreshIndicator(
            color: AppColors.accent,
            onRefresh: () async {
              context.read<PortfolioBloc>().add(
                const PortfolioFetchRequested(),
              );
              await Future.delayed(const Duration(milliseconds: 750));
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: [
                PortfolioSummaryCard(state: state),
                const SizedBox(height: AppSpacing.md),
                PerformanceChart(points: state.performance),
                const SizedBox(height: AppSpacing.md),
                AllocationChart(holdings: state.holdings),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(title: 'Holdings (${state.holdings.length})'),
                const SizedBox(height: AppSpacing.sm),
                ...state.holdings.map(
                  (h) => HoldingCard(
                    key: ValueKey(h.id),
                    holding: h,
                    isSelected: state.selectedHoldingId == h.id,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const SectionHeader(title: 'Recent transactions'),
                const SizedBox(height: AppSpacing.sm),
                TransactionsCard(transactions: state.transactions),
              ],
            ),
          );
        },
      ),
    ),
  );
}
