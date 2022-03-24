import 'dart:async';

import 'package:filterable_logger/src/filterable_logger.dart';
import 'package:logging/logging.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

typedef FL = FilterableLogger;

void main() {
  group('Basic Tests', () {
    final Completer<void> completer = Completer<void>();
    test('Current Log Level', () {
      expect(FL().currentLogLevel, Level.INFO);
      expect(FL.finest('This will not be shown') == null, true);
      expect(FL.info('Info will be printed')?.isNotEmpty == true, true);
      expect(FL.warning('Warning will be printed')?.isNotEmpty == true, true);
      expect(FL.severe('Severe will be printed')?.isNotEmpty == true, true);
      expect(FL.shout('Shout will be printed')?.isNotEmpty == true, true);
      completer.complete();
    });

    test('Filter', () async {
      await completer.future;
      FilterableLogger.setup(tagsFilter: <Object>['Show']);
      expect(FL().currentLogLevel, Level.INFO);
      expect(FL.info('This will not be shown') == null, true);
      expect(FL.warning('This will not be shown') == null, true);
      expect(
          FL.warning('Warning with `Show` tag will be printed',
                  tags: <Object>['Show'])?.isNotEmpty ==
              true,
          true);
    });
  });
}
