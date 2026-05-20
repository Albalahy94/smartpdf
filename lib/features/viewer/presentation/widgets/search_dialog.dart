import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<int> _searchResults = [];
  int _currentResultIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    // TODO: Implement actual PDF text search
    // This is a placeholder
    setState(() {
      _searchResults = [1, 5, 10, 15]; // Example page numbers
      _currentResultIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Search in Document'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter search term',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults = [];
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.blueTurquoise),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _performSearch(value);
              } else {
                setState(() {
                  _searchResults = [];
                });
              }
            },
            autofocus: true,
          ),
          if (_searchResults.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.blueTurquoise.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_searchResults.length} results found',
                    style: TextStyle(
                      color: AppTheme.blueTurquoise,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentResultIndex > 0
                            ? () {
                                setState(() {
                                  _currentResultIndex--;
                                });
                              }
                            : null,
                      ),
                      Text(
                        '${_currentResultIndex + 1}/${_searchResults.length}',
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _currentResultIndex < _searchResults.length - 1
                            ? () {
                                setState(() {
                                  _currentResultIndex++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (_searchResults.isNotEmpty)
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to search result page
              Navigator.pop(context, _searchResults[_currentResultIndex]);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.blueTurquoise,
              foregroundColor: Colors.white,
            ),
            child: const Text('Go to Result'),
          ),
      ],
    );
  }
}

