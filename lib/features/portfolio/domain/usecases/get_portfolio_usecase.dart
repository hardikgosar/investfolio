import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolioUseCase {
  final PortfolioRepository repository;

  const GetPortfolioUseCase(this.repository);

  Future<PortfolioEntity> call() => repository.getPortfolio();
}
