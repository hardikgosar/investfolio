import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_portfolio_usecase.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolioUseCase getPortfolioUseCase;
  PortfolioBloc({required this.getPortfolioUseCase})
    : super(const PortfolioState()) {
    on<PortfolioFetchRequested>(_onFetchRequested);
    on<PortfolioHoldingSelected>(_onHoldingSelected);
  }
  Future<void> _onFetchRequested(
    PortfolioFetchRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(state.copyWith(status: PortfolioStatus.loading, clearError: true));
    try {
      final portfolio = await getPortfolioUseCase();
      emit(
        state.copyWith(status: PortfolioStatus.success, portfolio: portfolio),
      );
    } on Failure catch (error) {
      emit(
        state.copyWith(
          status: PortfolioStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PortfolioStatus.failure,
          errorMessage: 'Could not load portfolio. Please try again.',
        ),
      );
    }
  }

  void _onHoldingSelected(
    PortfolioHoldingSelected event,
    Emitter<PortfolioState> emit,
  ) {
    final same = state.selectedHoldingId == event.holdingId;
    emit(
      state.copyWith(
        selectedHoldingId: same ? null : event.holdingId,
        clearSelection: same,
      ),
    );
  }
}
