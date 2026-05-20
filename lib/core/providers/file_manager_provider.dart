import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'settings_provider.dart';
import '../models/pdf_file.dart';

part 'file_manager_provider.g.dart';

@riverpod
class FileManager extends _$FileManager {
  static const _storageKey = 'saved_pdf_files';

  @override
  List<PdfFile> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final jsonList = prefs.getStringList(_storageKey) ?? [];
    try {
      return jsonList.map((item) => PdfFile.fromJson(json.decode(item) as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  void _saveToPrefs(List<PdfFile> files) {
    final prefs = ref.read(sharedPreferencesProvider);
    final jsonList = files.map((file) => json.encode(file.toJson())).toList();
    prefs.setStringList(_storageKey, jsonList);
  }

  void addFile(PdfFile file) {
    final newState = [...state, file];
    state = newState;
    _saveToPrefs(newState);
  }

  void removeFile(String fileId) {
    final newState = state.where((file) => file.id != fileId).toList();
    state = newState;
    _saveToPrefs(newState);
  }

  void updateFile(PdfFile updatedFile) {
    final newState = state.map((file) {
      return file.id == updatedFile.id ? updatedFile : file;
    }).toList();
    state = newState;
    _saveToPrefs(newState);
  }

  List<PdfFile> getRecentFiles() {
    final sorted = List<PdfFile>.from(state);
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(10).toList();
  }

  List<PdfFile> getFavoriteFiles() {
    return state.where((file) => file.isFavorite == true).toList();
  }

  List<PdfFile> getFilesByFolder(String? folderId) {
    if (folderId == null) {
      return state.where((file) => file.folderId == null).toList();
    }
    return state.where((file) => file.folderId == folderId).toList();
  }
}

