import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/models/pdf_file.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/bookmark_dialog.dart';
import '../widgets/search_dialog.dart';
import '../../../ocr/presentation/screens/ocr_screen.dart';
import '../../../translation/presentation/screens/translation_screen.dart';
import '../../../ai_tools/presentation/screens/ai_tools_screen.dart';

class PdfViewerScreen extends ConsumerStatefulWidget {
  final PdfFile pdfFile;

  const PdfViewerScreen({
    super.key,
    required this.pdfFile,
  });

  @override
  ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _currentPage = 1;
  int _totalPages = 0;
  bool _showToolbar = true;
  ThemeMode _viewerTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(() {
      setState(() {
        _currentPage = _pdfViewerController.pageNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pdfFile.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () async {
              final note = await showDialog<String>(
                context: context,
                builder: (context) => BookmarkDialog(
                  currentPage: _currentPage,
                ),
              );
              if (note != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bookmark added to page $_currentPage'),
                    backgroundColor: AppTheme.blueTurquoise,
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final page = await showDialog<int>(
                context: context,
                builder: (context) => const SearchDialog(),
              );
              if (page != null) {
                _pdfViewerController.jumpToPage(page);
              }
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.brightness_6),
                    SizedBox(width: 8),
                    Text('Theme'),
                  ],
                ),
                onTap: () => _showThemeSelector(),
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.translate),
                    SizedBox(width: 8),
                    Text('Translate'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TranslationScreen(
                        pdfFile: widget.pdfFile,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.text_fields),
                    SizedBox(width: 8),
                    Text('OCR'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OcrScreen(
                        pdfFile: widget.pdfFile,
                        pageNumber: _currentPage,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome),
                    SizedBox(width: 8),
                    Text('AI Tools'),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AiToolsScreen(
                        pdfFile: widget.pdfFile,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
                onTap: () {
                  // TODO: Share PDF
                },
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.file(
            File(widget.pdfFile.path),
            controller: _pdfViewerController,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _totalPages = details.document.pages.count;
              });
            },
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
          ),
          if (_showToolbar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildToolbar(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showToolbar = !_showToolbar;
          });
        },
        child: Icon(_showToolbar ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: _currentPage > 1
                ? () {
                    _pdfViewerController.jumpToPage(1);
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () {
                    _pdfViewerController.previousPage();
                  }
                : null,
          ),
          Text(
            '$_currentPage / $_totalPages',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < _totalPages
                ? () {
                    _pdfViewerController.nextPage();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: _currentPage < _totalPages
                ? () {
                    _pdfViewerController.jumpToPage(_totalPages);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Viewer Theme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildThemeOption('Light', ThemeMode.light, Icons.light_mode),
            const SizedBox(height: 16),
            _buildThemeOption('Dark', ThemeMode.dark, Icons.dark_mode),
            const SizedBox(height: 16),
            _buildThemeOption('Sepia', ThemeMode.system, Icons.filter_vintage),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title, ThemeMode mode, IconData icon) {
    final isSelected = _viewerTheme == mode;
    return ListTile(
      leading: Icon(icon, color: isSelected ? AppTheme.blueTurquoise : null),
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check, color: AppTheme.blueTurquoise)
          : null,
      onTap: () {
        setState(() {
          _viewerTheme = mode;
        });
        Navigator.pop(context);
        // TODO: Apply theme to PDF viewer
      },
    );
  }
}

