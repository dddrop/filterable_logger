import 'package:logging/logging.dart' show Level;
import 'package:stack_trace/stack_trace.dart' show Frame;

///
class LogRecord {
  ///
  LogRecord(
    this.level,
    this.message, [
    this.stackFrame,
  ])  : time = DateTime.now(),
        sequenceNumber = LogRecord._nextNumber++;

  ///
  final Level level;

  ///
  final String message;

  /// Time when this record was created.
  final DateTime time;

  /// Unique sequence number greater than all log records created before it.
  final int sequenceNumber;

  ///
  final Frame? stackFrame;

  static int _nextNumber = 0;
}
