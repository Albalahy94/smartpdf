import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../models/pdf_file.dart';

class FileService {
  static final FileService _instance = FileService._internal();
  factory FileService() => _instance;
  FileService._internal();

  Future<PdfFile?> pickPdfFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final file = File(filePath);
        final stat = await file.stat();

        return PdfFile(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: result.files.single.name,
          path: filePath,
          size: stat.size,
          createdAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final pdfDir = Directory(path.join(directory.path, 'pdfs'));
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir.path;
  }

  Future<String> savePdfFile(File sourceFile, String fileName) async {
    final appDir = await getAppDocumentsDirectory();
    final destPath = path.join(appDir, fileName);
    final destFile = File(destPath);
    
    await sourceFile.copy(destPath);
    return destPath;
  }

  Future<bool> deletePdfFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int?> getPdfPageCount(String filePath) async {
    // TODO: Implement PDF page count using pdfx or syncfusion
    return null;
  }
}

