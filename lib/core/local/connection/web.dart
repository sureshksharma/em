import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_web.dart';
import 'package:flutter/foundation.dart';
import 'package:sqlite3/wasm.dart';

Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  // This method validates that the actual schema of the opened database matches
  // the tables, views, triggers and indices for which drift_dev has generated
  // code.
  if (kDebugMode) {
    final sqlite = await WasmSqlite3.loadFromUrl(Uri.parse('/sqlite3.wasm'));
    sqlite.registerVirtualFileSystem(InMemoryFileSystem(), makeDefault: true);

    await VerifySelf(database).validateDatabaseSchema(sqlite3: sqlite);
  }
}
