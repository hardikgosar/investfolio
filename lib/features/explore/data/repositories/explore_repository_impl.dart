import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/explore_link_entity.dart';
import '../../domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  @override
  Future<List<ExploreLinkEntity>> getLinks() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [
      ExploreLinkEntity(
        id: 'l1',
        title: 'Loan Against Securities',
        subtitle: 'Sliqfin — instant LAS against your holdings',
        url: ExternalLinks.sliqfin,
        iconLabel: 'LS',
      ),
      ExploreLinkEntity(
        id: 'l2',
        title: 'Smallcase Baskets',
        subtitle: 'Explore curated stock & ETF portfolios',
        url: ExternalLinks.smallcase,
        iconLabel: 'SC',
      ),
      ExploreLinkEntity(
        id: 'l3',
        title: 'Flutter Documentation',
        subtitle: 'Official Flutter developer docs',
        url: ExternalLinks.flutterDev,
        iconLabel: 'FL',
      ),
      ExploreLinkEntity(
        id: 'l4',
        title: 'Search the Web',
        subtitle: 'Open Google in the in-app browser',
        url: ExternalLinks.google,
        iconLabel: 'G',
      ),
    ];
  }
}
