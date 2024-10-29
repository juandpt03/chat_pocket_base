import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

class ProviderStateLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    log('Provider added: ${provider.name ?? provider.runtimeType} with value: $value');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    log('Provider updated: ${provider.name ?? provider.runtimeType} '
        'from $previousValue to $newValue');
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);
    log('Provider disposed: ${provider.name ?? provider.runtimeType}');
  }
}
