import 'package:drift/drift.dart';

// This function is implemented differently per platform.
// The correct implementation is selected automatically at compile time.
Future<QueryExecutor> openDatabaseConnection() => throw UnsupportedError(
  'Cannot create a database without dart:io or dart:html',
);
