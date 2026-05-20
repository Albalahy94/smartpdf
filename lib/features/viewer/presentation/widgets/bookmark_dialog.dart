import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class BookmarkDialog extends StatefulWidget {
  final int currentPage;
  final String? existingNote;

  const BookmarkDialog({
    super.key,
    required this.currentPage,
    this.existingNote,
  });

  @override
  State<BookmarkDialog> createState() => _BookmarkDialogState();
}

class _BookmarkDialogState extends State<BookmarkDialog> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.existingNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Add Bookmark'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Page ${widget.currentPage}',
            style: TextStyle(
              color: AppTheme.blueTurquoise,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.blueTurquoise),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _noteController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.blueTurquoise,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

