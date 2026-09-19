import 'package:flutter_bloc/flutter_bloc.dart';
import 'browser_event.dart';
import 'browser_state.dart';

/// Drives the custom in-app browser (CustomBrowserView).
///
/// Note this BLoC does NOT own a WebViewController — that stays inside
/// the widget (platform view lifecycle belongs to the widget tree).
/// Instead the widget's controller callbacks (onProgress, onPageFinished,
/// onNavigationRequest, etc.) dispatch events here, and the BLoC emits
/// pure UI state (progress bar %, title, nav-button enablement) that
/// the widget listens to. This keeps the BLoC testable without a real
/// platform WebView.
class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  BrowserBloc() : super(const BrowserState()) {
    on<BrowserLoadRequested>(_onLoadRequested);
    on<BrowserProgressChanged>(_onProgressChanged);
    on<BrowserPageFinished>(_onPageFinished);
    on<BrowserErrorOccurred>(_onErrorOccurred);
    on<BrowserNavStateChanged>(_onNavStateChanged);
    // Back/forward/refresh are handled by the widget's controller;
    // the BLoC just needs to know they don't change loading state here.
    on<BrowserBackRequested>((e, emit) {});
    on<BrowserForwardRequested>((e, emit) {});
    on<BrowserRefreshRequested>((e, emit) {
      emit(state.copyWith(status: BrowserStatus.loading, progress: 0));
    });
  }

  void _onLoadRequested(
    BrowserLoadRequested event,
    Emitter<BrowserState> emit,
  ) {
    emit(
      state.copyWith(
        status: BrowserStatus.loading,
        url: event.url,
        progress: 0,
        errorMessage: null,
      ),
    );
  }

  void _onProgressChanged(
    BrowserProgressChanged event,
    Emitter<BrowserState> emit,
  ) {
    emit(state.copyWith(progress: event.progress));
  }

  void _onPageFinished(BrowserPageFinished event, Emitter<BrowserState> emit) {
    emit(
      state.copyWith(
        status: BrowserStatus.loaded,
        url: event.url,
        pageTitle: event.title,
        progress: 100,
      ),
    );
  }

  void _onErrorOccurred(
    BrowserErrorOccurred event,
    Emitter<BrowserState> emit,
  ) {
    emit(
      state.copyWith(status: BrowserStatus.error, errorMessage: event.message),
    );
  }

  void _onNavStateChanged(
    BrowserNavStateChanged event,
    Emitter<BrowserState> emit,
  ) {
    emit(
      state.copyWith(
        canGoBack: event.canGoBack,
        canGoForward: event.canGoForward,
      ),
    );
  }
}
