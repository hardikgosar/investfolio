import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/browser_bloc.dart';
import '../bloc/browser_event.dart';
import '../bloc/browser_state.dart';

/// A fully custom in-app browser — NOT the OS-provided Chrome
/// Custom Tabs / SFSafariViewController. We own the WebViewController,
/// the chrome (address bar, progress bar, nav buttons) and the
/// lifecycle, which is what "custom widget to call a website" implies
/// for this assignment (demonstrates WebView platform-view integration
/// + BLoC wiring, not just url_launcher).
class CustomBrowserView extends StatefulWidget {
  final String initialUrl;

  const CustomBrowserView({
    super.key,
    required this.initialUrl,
  });

  @override
  State<CustomBrowserView> createState() => _CustomBrowserViewState();
}

class _CustomBrowserViewState extends State<CustomBrowserView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _buildController();
  }

WebViewController _buildController() {
  final bloc = context.read<BrowserBloc>();

  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(AppColors.surface)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          if (!mounted) return;

          bloc.add(
            BrowserProgressChanged(progress),
          );
        },

        onPageStarted: (url) {
          if (!mounted) return;

          bloc.add(
            BrowserLoadRequested(url),
          );
        },

        onPageFinished: (url) async {
          if (!mounted) return;

          final title = await _controller.getTitle();

          if (!mounted) return;

          bloc.add(
            BrowserPageFinished(url, title),
          );

          await _syncNavState(bloc);
        },

        onWebResourceError: (error) {
          if (!mounted) return;

          bloc.add(
            BrowserErrorOccurred(error.description),
          );
        },

        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
      Uri.parse(widget.initialUrl),
    );
}
 Future<void> _syncNavState(BrowserBloc bloc) async {
  if (!mounted) return;

  final canGoBack = await _controller.canGoBack();
  final canGoForward = await _controller.canGoForward();

  if (!mounted) return;

  bloc.add(
    BrowserNavStateChanged(
      canGoBack: canGoBack,
      canGoForward: canGoForward,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DragHandle(),
        _BrowserChrome(controller: _controller, onSync: _syncNavState),
        BlocBuilder<BrowserBloc, BrowserState>(
          buildWhen: (prev, curr) => prev.progress != curr.progress,
          builder: (context, state) {
            if (state.progress >= 100 || state.progress == 0) {
              return const SizedBox(height: 2);
            }
            return LinearProgressIndicator(
              value: state.progress / 100,
              minHeight: 2,
              backgroundColor: AppColors.divider,
              color: AppColors.accent,
            );
          },
        ),
        Expanded(
          child: BlocBuilder<BrowserBloc, BrowserState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              return Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (state.status == BrowserStatus.error)
                    _BrowserErrorOverlay(
                      message: state.errorMessage ?? 'Something went wrong.',
                      onRetry: () => _controller.reload(),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    );
  }
}

/// The browser "chrome": back/forward, address pill, close, open-external.
class _BrowserChrome extends StatelessWidget {
  final WebViewController controller;
  final Future<void> Function(BrowserBloc bloc) onSync;

  const _BrowserChrome({required this.controller, required this.onSync});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BrowserBloc>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: BlocBuilder<BrowserBloc, BrowserState>(
        buildWhen: (prev, curr) =>
            prev.canGoBack != curr.canGoBack ||
            prev.canGoForward != curr.canGoForward ||
            prev.url != curr.url ||
            prev.pageTitle != curr.pageTitle,
        builder: (context, state) {
          return Row(
            children: [
              IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: state.canGoBack
                    ? () async {
                        await controller.goBack();
                        await onSync(bloc);
                      }
                    : null,
              ),
              IconButton(
                tooltip: 'Forward',
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                onPressed: state.canGoForward
                    ? () async {
                        await controller.goForward();
                        await onSync(bloc);
                      }
                    : null,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline_rounded,
                          size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          state.url.isEmpty ? 'Loading…' : state.url,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh_rounded, size: 20),
                onPressed: () {
                  bloc.add(const BrowserRefreshRequested());
                  controller.reload();
                },
              ),
              IconButton(
                tooltip: 'Close',
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BrowserErrorOverlay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _BrowserErrorOverlay({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded,
              size: 40, color: AppColors.textDisabled),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
