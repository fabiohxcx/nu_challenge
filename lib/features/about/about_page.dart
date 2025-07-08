import 'package:flutter/material.dart';
import 'package:nu_challenge/core/theme/app_spacing.dart';
import 'package:nu_challenge/core/theme/app_text_styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// {@category Features}
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About this App")),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("URL Shortener App", style: context.titleLarge),
            const SizedBox(height: AppSpacing.md),
            Text(
              'This application was developed as a technical challenge. '
              'It allows users to shorten URLs and view a history of recently shortened links.',
              style: context.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Version: $_appVersion', style: context.bodyMedium),
          ],
        ),
      ),
    );
  }
}
