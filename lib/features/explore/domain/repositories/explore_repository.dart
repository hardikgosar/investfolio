import '../entities/explore_link_entity.dart';

abstract class ExploreRepository {
  Future<List<ExploreLinkEntity>> getLinks();
}
