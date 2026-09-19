import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investfolio/core/routes/root_shell.dart';

import 'core/theme/app_theme.dart';
import 'features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/get_portfolio_usecase.dart';
import 'features/portfolio/presentation/bloc/portfolio_bloc.dart';

void main() {
  runApp(const InvestfolioApp());
}

class InvestfolioApp extends StatelessWidget {
  const InvestfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioDataSource = PortfolioLocalDataSourceImpl();
    final portfolioRepository = PortfolioRepositoryImpl(
      localDataSource: portfolioDataSource,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PortfolioBloc(
            getPortfolioUseCase: GetPortfolioUseCase(portfolioRepository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Investfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const RootShell(),
      ),
    );

    
  }
}
