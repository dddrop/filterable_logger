# Filterable Logger

[![pub package](https://img.shields.io/badge/filterable__logger-v0.0.4-green)](https://pub.dev/packages/filterable_logger)

A filterable logger with colored output for different log level.

## Features

- Log level definition is based on dart [logging](https://pub.dev/packages/logging) package.

```lang=dart
Level.OFF
Level.SHOUT
Level.SEVERE
Level.WARNING
Level.INFO
Level.CONFIG
Level.FINE
Level.FINER
Level.FINEST
```

- Colored output

<img src="https://github.com/dddrop/filterable_logger/blob/main/resources/color_output.png" width="400"  alt="Colored output"/>

- Filterable
    
    To suppress unuseful log info, tags filter will work.

```lang=dart
// Set tags filter
FilterableLogger.setup(tagsFilter: <Object>['Network']);

// This will be printed.
FilterableLogger.info('Message', tags: <Object>['Network', 'Debug']);

// This will not be printed
FilterableLogger.info('Message', tags: <Object>['Debug']);
```

## Usage

```lang=dart
// Basic usage
FilterableLogger.shout('This is \'SHOUT\' log.');

FilterableLogger.severe('This is \'SEVERE\' log.');

FilterableLogger.warning('This is \'WARNING\' log.');

FilterableLogger.info('This is \'INFO\' log.');

FilterableLogger.config('This is \'CONFIG\' log.');

FilterableLogger.fine('This is \'FINE\' log.');

FilterableLogger.finer('This is \'FINER\' log.');

FilterableLogger.finest('This is \'FINEST\' log.');
```

```lang=dart
// Logger configurations
FilterableLogger.setup(
  level: Level.INFO,
  showTraceInfo: true,
  traceLevel: 3,
  format: (LogRecord record) {
    return 'Customized log format';
  },
  tagsFilter: <Object>['Filters'],
  afterLogging: (LogRecord record){
    // Callback after log successfully
  },
);
```
