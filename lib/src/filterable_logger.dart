import 'package:logging/logging.dart' show Level;
import 'package:stack_trace/stack_trace.dart' show Frame, Trace;

import 'log_record.dart';

///
typedef LogFormat = String Function(LogRecord);

///
typedef LogRecordCallback = Function(LogRecord);

///
class FilterableLogger {
  ///
  factory FilterableLogger() => _shared;

  FilterableLogger._();

  static final FilterableLogger _shared = FilterableLogger._();

  ///
  Level get currentLogLevel => _level;

  bool _isLoggable(Level value) => value >= currentLogLevel;
  int _traceLevel = 3;
  Level _level = Level.INFO;
  LogFormat? _globalFormat;
  List<Object>? _tagsFilter;
  LogRecordCallback? _afterLogging;
  bool _showTraceInfo = true;

  ///
  static void setup({
    Level level = Level.INFO,
    bool showTraceInfo = true,
    int traceLevel = 3,
    LogFormat? format,
    List<Object>? tagsFilter,
    LogRecordCallback? afterLogging,
  }) {
    _shared._level = level;
    _shared._traceLevel = traceLevel;
    _shared._globalFormat = format;
    _shared._tagsFilter = tagsFilter;
    _shared._afterLogging = afterLogging;
    _shared._showTraceInfo = showTraceInfo;
  }

  ///
  String? log(Level logLevel, Object? message,
      {List<Object>? tags, LogFormat? customFormat}) {
    if (_isLoggable(logLevel)) {
      if (message is Function) {
        message = message();
      }

      String msg;
      if (message is String) {
        msg = message;
      } else {
        msg = message.toString();
      }

      final LogRecord record = LogRecord(logLevel, msg, _stackFrame);
      final LogFormat usableFormat =
          customFormat ?? _globalFormat ?? _defaultFormat;

      if (_tagsFilter == null ||
          _tagsFilter?.isEmpty == true ||
          tags
                  ?.map((Object e) => _tagsFilter?.contains(e))
                  .where((bool? e) => e == true)
                  .isNotEmpty ==
              true) {
        final String log = usableFormat(record);
        print(log);
        _afterLogging?.call(record);
        return log;
      }
    }
    return null;
  }

  ///
  static String? finest(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINEST, message, tags: tags);

  ///
  static String? finer(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINER, message, tags: tags);

  ///
  static String? fine(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINE, message, tags: tags);

  ///
  static String? config(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.CONFIG, message, tags: tags);

  ///
  static String? info(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.INFO, message, tags: tags);

  ///
  static String? warning(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.WARNING, message, tags: tags);

  ///
  static String? severe(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.SEVERE, message, tags: tags);

  ///
  static String? shout(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.SHOUT, message, tags: tags);

  ///
  static String? l1(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINEST, message, tags: tags);

  ///
  static String? l2(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINER, message, tags: tags);

  ///
  static String? l3(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.FINE, message, tags: tags);

  ///
  static String? l4(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.CONFIG, message, tags: tags);

  ///
  static String? l5(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.INFO, message, tags: tags);

  ///
  static String? l6(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.WARNING, message, tags: tags);

  ///
  static String? l7(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.SEVERE, message, tags: tags);

  ///
  static String? l8(Object? message, {List<Object>? tags}) =>
      _shared.log(Level.SHOUT, message, tags: tags);

  LogFormat get _defaultFormat {
    return (LogRecord record) {
      String message = '${_colorPrefix[record.level]}';
      message += '[${record.level}]';
      message += ' ${record.time}';
      if (record.stackFrame != null && _showTraceInfo) {
        message += ' ${record.stackFrame}';
      }
      message += ': ${record.message}';
      message += _colorReset;
      return message;
    };
  }

  Frame? get _stackFrame {
    final List<Frame> frames = Trace.current(_traceLevel).frames;
    return frames.isEmpty ? null : frames.first;
  }
}

final Map<Level, String> _colorPrefix = <Level, String>{
  Level.FINEST: '\u001b[38;5;240m',
  Level.FINER: '\u001b[38;5;245m',
  Level.FINE: '\u001b[38;5;250m',
  Level.CONFIG: '\u001b[38;5;255m',
  Level.INFO: '\u001b[38;5;105m',
  Level.WARNING: '\u001b[38;5;220m',
  Level.SEVERE: '\u001b[38;5;208m',
  Level.SHOUT: '\u001b[38;5;196m',
};

const String _colorReset = '\u001b[0m';
