import 'package:equatable/equatable.dart';

enum BrowserStatus { idle, loading, loaded, error }

class BrowserState extends Equatable {
  final BrowserStatus status;
  final String url;
  final String? pageTitle;
  final int progress;
  final bool canGoBack;
  final bool canGoForward;
  final String? errorMessage;

  const BrowserState({
    this.status = BrowserStatus.idle,
    this.url = '',
    this.pageTitle,
    this.progress = 0,
    this.canGoBack = false,
    this.canGoForward = false,
    this.errorMessage,
  });

  BrowserState copyWith({
    BrowserStatus? status,
    String? url,
    String? pageTitle,
    int? progress,
    bool? canGoBack,
    bool? canGoForward,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BrowserState(
      status: status ?? this.status,
      url: url ?? this.url,
      pageTitle: pageTitle ?? this.pageTitle,
      progress: progress ?? this.progress,
      canGoBack: canGoBack ?? this.canGoBack,
      canGoForward: canGoForward ?? this.canGoForward,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        url,
        pageTitle,
        progress,
        canGoBack,
        canGoForward,
        errorMessage,
      ];
}