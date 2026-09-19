import 'package:equatable/equatable.dart';

abstract class BrowserEvent extends Equatable {
  const BrowserEvent();
  @override
  List<Object?> get props => [];
}

class BrowserLoadRequested extends BrowserEvent {
  final String url;
  const BrowserLoadRequested(this.url);

  @override
  List<Object?> get props => [url];
}

class BrowserProgressChanged extends BrowserEvent {
  final int progress; // 0-100
  const BrowserProgressChanged(this.progress);

  @override
  List<Object?> get props => [progress];
}

class BrowserPageFinished extends BrowserEvent {
  final String url;
  final String? title;
  const BrowserPageFinished(this.url, this.title);

  @override
  List<Object?> get props => [url, title];
}

class BrowserErrorOccurred extends BrowserEvent {
  final String message;
  const BrowserErrorOccurred(this.message);

  @override
  List<Object?> get props => [message];
}

class BrowserBackRequested extends BrowserEvent {
  const BrowserBackRequested();
}

class BrowserForwardRequested extends BrowserEvent {
  const BrowserForwardRequested();
}

class BrowserRefreshRequested extends BrowserEvent {
  const BrowserRefreshRequested();
}

/// Reported by the controller so BLoC knows whether back/forward
/// buttons should be enabled — a good example of the widget pushing
/// capability info up into state rather than the UI querying the
/// controller directly on every build.
class BrowserNavStateChanged extends BrowserEvent {
  final bool canGoBack;
  final bool canGoForward;
  const BrowserNavStateChanged({
    required this.canGoBack,
    required this.canGoForward,
  });

  @override
  List<Object?> get props => [canGoBack, canGoForward];
}
