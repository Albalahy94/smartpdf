import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path/path.dart' as path;
import '../models/pdf_file.dart';
import 'file_service.dart';
import '../theme/app_theme.dart';
import '../localization/app_localizations.dart';

class PdfCreationService {
  final ImagePicker _picker = ImagePicker();
  final FileService _fileService = FileService();

  // 1. Scan Document (Camera -> Images -> Multi-page PDF)
  Future<PdfFile?> scanDocumentToPdf(BuildContext context) async {
    try {
      final List<List<int>> allImagesBytes = [];
      bool addingPages = true;
      final loc = AppLocalizations.of(context)!;

      while (addingPages) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85, // Optimize file size for PDFs
        );
        
        if (image == null) {
          // If they cancel the first capture, cancel the whole scan.
          if (allImagesBytes.isEmpty) return null;
          break; 
        }

        final File imageFile = File(image.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        allImagesBytes.add(imageBytes);

        // Ask the user if they want to scan another page
        if (context.mounted) {
          final bool? scanMore = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).brightness == Brightness.dark 
                  ? AppTheme.deepSlateCard 
                  : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(
                loc.translate('scanNextPageTitle'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                ),
              ),
              content: Text(
                loc.translate('scanNextPagePrompt', arguments: {
                  'count': allImagesBytes.length.toString()
                }),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false), // Done
                  child: Text(
                    loc.translate('done'),
                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.blueTurquoise,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () => Navigator.pop(context, true), // Scan More
                  child: Text(
                    loc.translate('scanMore'),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
          addingPages = scanMore ?? false;
        } else {
          addingPages = false;
        }
      }

      if (allImagesBytes.isEmpty) return null;

      final PdfDocument document = PdfDocument();
      document.pageSettings.margins.all = 20;

      for (final imageBytes in allImagesBytes) {
        final PdfPage page = document.pages.add();
        final PdfBitmap pdfBitmap = PdfBitmap(imageBytes);
        page.graphics.drawImage(
          pdfBitmap,
          Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height),
        );
      }

      final List<int> bytes = await document.save();
      document.dispose();

      // Save locally using FileService
      final String fileName = 'Scanned_Doc_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final String appDir = await _fileService.getAppDocumentsDirectory();
      final String destPath = path.join(appDir, fileName);
      final File file = File(destPath);
      await file.writeAsBytes(bytes);

      return PdfFile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: fileName,
        path: destPath,
        size: await file.length(),
        createdAt: DateTime.now(),
        pageCount: allImagesBytes.length,
      );
    } catch (e) {
      debugPrint('Error scanning doc: $e');
      return null;
    }
  }

  // 2. Create Text PDF (Supports Arabic & Unicode)
  Future<PdfFile?> createTextPdf(String title, String content) async {
    try {
      final PdfDocument document = PdfDocument();
      document.pageSettings.margins.all = 40;
      final PdfPage page = document.pages.add();

      // Load Cairo-Regular.ttf font to support Arabic/Unicode drawing correctly
      final ByteData fontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      final List<int> fontBytes = fontData.buffer.asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
      
      final PdfTrueTypeFont titleFont = PdfTrueTypeFont(fontBytes, 22, style: PdfFontStyle.bold);
      final PdfTrueTypeFont bodyFont = PdfTrueTypeFont(fontBytes, 14);

      // Check if text is Arabic to set Right-to-Left alignment
      final bool isArabic = _containsArabic(content) || _containsArabic(title);
      final PdfTextAlignment alignment = isArabic ? PdfTextAlignment.right : PdfTextAlignment.left;
      final PdfTextDirection textDirection = isArabic ? PdfTextDirection.rightToLeft : PdfTextDirection.leftToRight;

      // Draw Title
      page.graphics.drawString(
        title.isEmpty ? 'Untitled Document' : title,
        titleFont,
        bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, 50),
        format: PdfStringFormat(
          alignment: alignment,
          textDirection: textDirection,
        ),
      );

      // Draw Content
      page.graphics.drawString(
        content,
        bodyFont,
        bounds: Rect.fromLTWH(0, 60, page.getClientSize().width, page.getClientSize().height - 60),
        format: PdfStringFormat(
          wordWrap: PdfWordWrapType.word,
          alignment: alignment,
          textDirection: textDirection,
        ),
      );

      final List<int> bytes = await document.save();
      document.dispose();

      final String safeTitle = title.trim().isEmpty ? 'Document' : title.replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '_').replaceAll(' ', '_');
      final String fileName = '${safeTitle}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final String appDir = await _fileService.getAppDocumentsDirectory();
      final String destPath = path.join(appDir, fileName);
      final File file = File(destPath);
      await file.writeAsBytes(bytes);

      return PdfFile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: fileName,
        path: destPath,
        size: await file.length(),
        createdAt: DateTime.now(),
        pageCount: 1,
      );
    } catch (e) {
      debugPrint('Error creating text PDF: $e');
      return null;
    }
  }

  bool _containsArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }
}
