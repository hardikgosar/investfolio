import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  const PortfolioRepositoryImpl({required this.localDataSource});

  @override
  Future<PortfolioEntity> getPortfolio() async {
    try {
      final model = await localDataSource.getPortfolio();
      return model.toEntity();
    } on AppException catch (error) {
      throw DataFailure(error.message);
    }
  }
}
