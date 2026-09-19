import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_explore_links_usecase.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetExploreLinksUseCase getExploreLinksUseCase;

  ExploreBloc({required this.getExploreLinksUseCase})
      : super(const ExploreState()) {
    on<ExploreFetchRequested>(_onFetchRequested);
    on<ExploreLinkTapped>(_onLinkTapped);
    on<ExploreSheetDismissed>(_onSheetDismissed);
  }

  Future<void> _onFetchRequested(
    ExploreFetchRequested event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      final links = await getExploreLinksUseCase();
      emit(state.copyWith(status: ExploreStatus.success, links: links));
    } catch (e) {
      emit(state.copyWith(
        status: ExploreStatus.failure,
        errorMessage: 'Could not load links.',
      ));
    }
  }

  void _onLinkTapped(ExploreLinkTapped event, Emitter<ExploreState> emit) {
    final matches = state.links.where((l) => l.id == event.linkId);
    if (matches.isNotEmpty) {
      emit(state.copyWith(activeLink: matches.first));
    }
  }

  void _onSheetDismissed(
    ExploreSheetDismissed event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(clearActiveLink: true));
  }
}
