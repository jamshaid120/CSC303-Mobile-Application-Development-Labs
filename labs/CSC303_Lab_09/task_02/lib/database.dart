import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().withLength(min: 1, max: 200)();
}

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'csc303_notes'));
  @override
  int get schemaVersion => 1;

  Stream<List<Note>> watchNotes() => select(notes).watch();
  Future<int> createNote(String content) =>
      into(notes).insert(NotesCompanion.insert(content: content));
  Future<int> updateNote(int id, String content) =>
      (update(notes)..where((t) => t.id.equals(id))).write(
        NotesCompanion(content: Value(content)),
      );

  Future<int> deleteNote(int id) =>
      (delete(notes)..where((t) => t.id.equals(id))).go();
}
