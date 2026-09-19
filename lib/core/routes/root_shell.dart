import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/explore/data/repositories/explore_repository_impl.dart';
import '../../features/explore/domain/usecases/get_explore_links_usecase.dart';
import '../../features/explore/presentation/bloc/explore_bloc.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/portfolio/presentation/screens/portfolio_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/webview/presentation/widgets/browser_bottom_sheet.dart';

/// Root navigation shell — an IndexedStack-backed bottom nav bar.
/// IndexedStack (rather than swapping the Navigator's page) keeps each
/// tab's scroll position and BLoC state alive when switching tabs,
/// which is the standard pattern for this kind of app.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  void _goToPortfolioTab() => setState(() => _currentIndex = 1);

  Future<void> _openLink(String url) async {
    await showBrowserBottomSheet(context, url: url);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        onSeeAllHoldings: _goToPortfolioTab,
        onOpenLink: _openLink,
      ),
      const PortfolioScreen(),
      BlocProvider(
        create: (_) => ExploreBloc(
          getExploreLinksUseCase:
              GetExploreLinksUseCase(ExploreRepositoryImpl()),
        ),
        child: const ExploreScreen(),
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_rounded),
            activeIcon: Icon(Icons.pie_chart_rounded),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

