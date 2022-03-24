import 'dart:async';

import 'package:filterable_logger/src/filterable_logger.dart';
import 'package:logging/logging.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

void main() {
  group('Basic Tests', () {
    final Completer<void> completer = Completer<void>();
    test('Current Log Level', () {
      expect(FilterableLogger().currentLogLevel, Level.INFO);
      expect(FilterableLogger.finest('This will not be shown') == null, true);
      expect(FilterableLogger.info('Info will be printed')?.isNotEmpty == true,
          true);
      expect(
          FilterableLogger.warning('Warning will be printed')?.isNotEmpty ==
              true,
          true);
      expect(
          FilterableLogger.severe('Severe will be printed')?.isNotEmpty == true,
          true);
      expect(
          FilterableLogger.shout('Shout will be printed')?.isNotEmpty == true,
          true);
      completer.complete();
    });

    test('Filter', () async {
      await completer.future;
      FilterableLogger.setup(tagsFilter: <Object>['Show']);
      expect(FilterableLogger().currentLogLevel, Level.INFO);
      expect(FilterableLogger.info('This will not be shown') == null, true);
      expect(FilterableLogger.warning('This will not be shown') == null, true);
      expect(
          FilterableLogger.warning('Warning with `Show` tag will be printed',
                  tags: <Object>['Show'])?.isNotEmpty ==
              true,
          true);
    });
  });
}
