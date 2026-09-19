import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../portfolio/presentation/bloc/portfolio_bloc.dart';
import '../../../portfolio/presentation/bloc/portfolio_event.dart';
import '../../../portfolio/presentation/bloc/portfolio_state.dart';
import '../../../portfolio/presentation/widgets/performance_chart.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/holding_mini_row.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onSeeAllHoldings;
  final ValueChanged<String> onOpenLink;
  const DashboardScreen({
    super.key,
    required this.onSeeAllHoldings,
    required this.onOpenLink,
  });
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PortfolioBloc>().add(const PortfolioFetchRequested());
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () async {
        context.read<PortfolioBloc>().add(const PortfolioFetchRequested());
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
          const _Header(),
          const SizedBox(height: AppSpacing.md),
          const _HeroBalanceCard(),
          const SizedBox(height: AppSpacing.lg),
          _QuickActionsRow(onOpenLink: widget.onOpenLink),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(
            title: 'Your Holdings',
            actionLabel: 'See all',
            onActionTap: widget.onSeeAllHoldings,
          ),
          const SizedBox(height: AppSpacing.sm),
          const _DashboardHoldings(),
          const SizedBox(height: AppSpacing.lg),
          BlocSelector<PortfolioBloc, PortfolioState, List<dynamic>>(
            selector: (s) => s.performance,
            builder: (context, points) =>
                PerformanceChart(points: points.cast()),
          ),
        ],
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext c) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning, Hardik!',
            style: Theme.of(c).textTheme.titleMedium,
          ),
          Text(
            'Here\'s your investment overview ',
            style: Theme.of(c).textTheme.titleSmall,
          ),
        ],
      ),
      Expanded(child: Container()),
      Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
        ),
        child: const Icon(
          Icons.notifications_none_rounded,
          color: AppColors.textPrimary,
          size: 22,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
        ),
        child: const Icon(Icons.person, color: AppColors.textPrimary, size: 22),
      ),
    ],
  );
}

class _HeroBalanceCard extends StatelessWidget {
  const _HeroBalanceCard();
  @override
  Widget build(
    BuildContext c,
  ) => BlocSelector<PortfolioBloc, PortfolioState, _HeroData>(
    selector: (s) => _HeroData(
      s.totalPortfolioValue,
      s.totalInvested,
      s.totalReturns,
      s.totalReturnsPercent,
      s.dayChange,
      s.dayChangePercent,
    ),
    builder: (c, d) {
      final p = d.returns >= 0;
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
              'Total portfolio value',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              '₹${d.value.toStringAsFixed(0)}',
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
                  p ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                  color: p ? AppColors.profitGreen : Colors.redAccent,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${p ? '+' : ''}₹${d.returns.toStringAsFixed(0)} (${d.returnsPct.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    color: p ? AppColors.profitGreen : Colors.redAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  'Today ${d.dayChange >= 0 ? '+' : ''}₹${d.dayChange.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                _M('Invested', '₹${d.invested.toStringAsFixed(0)}'),
                _M(
                  'Today',
                  '${d.dayChangePct >= 0 ? '+' : ''}${d.dayChangePct.toStringAsFixed(2)}%',
                ),
                _M('Value', '₹${d.value.toStringAsFixed(0)}'),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _HeroData {
  final double value, invested, returns, returnsPct, dayChange, dayChangePct;
  const _HeroData(
    this.value,
    this.invested,
    this.returns,
    this.returnsPct,
    this.dayChange,
    this.dayChangePct,
  );
  @override
  bool operator ==(Object o) =>
      o is _HeroData &&
      value == o.value &&
      invested == o.invested &&
      returns == o.returns &&
      returnsPct == o.returnsPct &&
      dayChange == o.dayChange &&
      dayChangePct == o.dayChangePct;
  @override
  int get hashCode => Object.hash(
    value,
    invested,
    returns,
    returnsPct,
    dayChange,
    dayChangePct,
  );
}

class _M extends StatelessWidget {
  final String l, v;
  const _M(this.l, this.v);
  @override
  Widget build(BuildContext c) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          v,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

class _QuickActionsRow extends StatelessWidget {
  final ValueChanged<String> onOpenLink;
  const _QuickActionsRow({required this.onOpenLink});
  @override
  Widget build(BuildContext c) => Row(
    children: [
      Expanded(
        child: QuickActionButton(
          icon: Icons.add_rounded,
          label: 'Invest',
          onTap: () {},
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: QuickActionButton(
          icon: Icons.currency_exchange_rounded,
          label: 'Withdraw',
          onTap: () {},
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: QuickActionButton(
          icon: Icons.receipt_long_rounded,
          label: 'Reports',
          onTap: () {},
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: QuickActionButton(
          icon: Icons.link_rounded,
          label: 'Web',
          onTap: () => onOpenLink(ExternalLinks.google),
        ),
      ),
    ],
  );
}

class _DashboardHoldings extends StatelessWidget {
  const _DashboardHoldings();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PortfolioBloc, PortfolioState, List<dynamic>>(
      selector: (state) => state.holdings,
      builder: (context, holdings) {
        if (holdings.isEmpty) {
          return const _HoldingsSkeleton();
        }

        return Column(
          children: holdings.take(3).map((holding) {
            return Padding(
              key: ValueKey(holding.id),
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: HoldingMiniRow(holding: holding),
            );
          }).toList(),
        );
      },
    );
  }
}

class _HoldingsSkeleton extends StatelessWidget {
  const _HoldingsSkeleton();
  @override
  Widget build(BuildContext c) => Column(
    children: List.generate(
      3,
      (i) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    ),
  );
}
