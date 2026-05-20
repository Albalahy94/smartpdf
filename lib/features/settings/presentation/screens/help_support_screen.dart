import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            'How do I convert a file to PDF?',
            'Go to the "Conversion" tab, select your file, and tap "Convert Now".',
          ),
          _buildFaqItem(
            'Where are my saved files?',
            'All converted and edited files are stored in the "Files" tab and your chosen storage location.',
          ),
          _buildFaqItem(
            'How do I cancel my subscription?',
            'You can manage your subscription through the Profile screen or your app store settings.',
          ),
          const SizedBox(height: 32),
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.email, color: AppTheme.blueTurquoise),
            title: const Text('Email Support'),
            subtitle: const Text('support@smartpdf.ai'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.web, color: AppTheme.blueTurquoise),
            title: const Text('Visit Website'),
            subtitle: const Text('www.smartpdf.ai'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
