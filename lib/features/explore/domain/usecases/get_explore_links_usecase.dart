import '../entities/explore_link_entity.dart';
import '../repositories/explore_repository.dart';

class GetExploreLinksUseCase {
  final ExploreRepository repository;
  const GetExploreLinksUseCase(this.repository);

  Future<List<ExploreLinkEntity>> call() => repository.getLinks();
}
