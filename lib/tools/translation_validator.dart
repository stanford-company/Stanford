#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

/// Translation Coverage Analysis Tool
/// This script scans the Flutter app for untranslated strings and provides coverage statistics
class TranslationValidator {
  static const List<String> commonPatterns = [
    r'Text\s*\(\s*["\x27][^"\x27\$]*["\x27](?!\s*\.tr\(\))',
    r'hintText:\s*["\x27][^"\x27\$]*["\x27](?!\s*\.tr\(\))',
    r'labelText:\s*["\x27][^"\x27\$]*["\x27](?!\s*\.tr\(\))',
    r'AppBar\(title:\s*Text\(["\x27][^"\x27\$]*["\x27]\)',
    r'SnackBar\(content:\s*Text\(["\x27][^"\x27\$]*["\x27]\)',
    r'AlertDialog\(title:\s*Text\(["\x27][^"\x27\$]*["\x27]\)',
  ];

  static const List<String> excludePatterns = [
    r'//.*', // Comments
    r'print\(', // Debug prints
    r'debugPrint\(', // Debug prints
    r'^\s*import', // Import statements
    r'part of', // Part statements
    r'class\s+\w+', // Class declarations
    r'enum\s+\w+', // Enum declarations
  ];

  static Map<String, dynamic> translationKeys = {};
  static List<String> untranslatedStrings = [];
  static Map<String, List<String>> fileIssues = {};

  static Future<void> main() async {
    print('🔍 Starting Translation Coverage Analysis...\n');

    // Load translation keys
    await loadTranslationKeys();

    // Scan Dart files
    await scanDartFiles();

    // Generate report
    generateReport();
  }

  static Future<void> loadTranslationKeys() async {
    try {
      final file = File('assets/languages/en-US.json');
      final content = await file.readAsString();
      translationKeys = json.decode(content);
      print('✅ Loaded ${translationKeys.length} translation keys');
    } catch (e) {
      print('❌ Error loading translation keys: $e');
    }
  }

  static Future<void> scanDartFiles() async {
    final libDir = Directory('lib');
    final dartFiles = await libDir
        .list(recursive: true)
        .where((entity) => entity.path.endsWith('.dart'))
        .cast<File>()
        .toList();

    print('📁 Scanning ${dartFiles.length} Dart files...\n');

    for (final file in dartFiles) {
      await scanFile(file);
    }
  }

  static Future<void> scanFile(File file) async {
    try {
      final content = await file.readAsString();
      final lines = content.split('\n');
      final issues = <String>[];

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];

        // Skip excluded patterns
        if (excludePatterns.any((pattern) => RegExp(pattern).hasMatch(line))) {
          continue;
        }

        // Check for untranslated strings
        for (final pattern in commonPatterns) {
          final regex = RegExp(pattern);
          final matches = regex.allMatches(line);

          for (final match in matches) {
            final matchedText = match.group(0) ?? '';
            if (matchedText.isNotEmpty) {
              issues.add('Line ${i + 1}: $matchedText');
              untranslatedStrings.add(matchedText);
            }
          }
        }
      }

      if (issues.isNotEmpty) {
        fileIssues[file.path] = issues;
      }
    } catch (e) {
      print('❌ Error scanning ${file.path}: $e');
    }
  }

  static void generateReport() {
    print('📊 TRANSLATION COVERAGE REPORT');
    print('=' * 50);

    final totalFiles = fileIssues.keys.length;
    final totalIssues = untranslatedStrings.length;

    print('📁 Files with untranslated strings: $totalFiles');
    print('🔤 Total untranslated strings found: $totalIssues');
    print('🗝️  Available translation keys: ${translationKeys.length}');

    if (totalIssues == 0) {
      print('\n🎉 EXCELLENT! No untranslated strings found!');
      return;
    }

    print('\n📋 DETAILED BREAKDOWN:');
    print('-' * 30);

    fileIssues.forEach((filePath, issues) {
      final relativePath = filePath.replaceFirst(RegExp(r'^.*lib/'), 'lib/');
      print('\n📄 $relativePath (${issues.length} issues):');

      for (final issue in issues.take(3)) {
        // Show first 3 issues
        print('  • $issue');
      }

      if (issues.length > 3) {
        print('  ... and ${issues.length - 3} more');
      }
    });

    print('\n🔧 SUGGESTED ACTIONS:');
    print('-' * 20);
    print(
      '1. Add Easy Localization import: import \'package:easy_localization/easy_localization.dart\';',
    );
    print('2. Replace hardcoded strings with .tr() calls');
    print('3. Add missing translation keys to assets/languages/');
    print('4. Test with different locales');

    print('\n📈 PRIORITY FILES TO FIX:');
    print('-' * 25);

    final sortedFiles = fileIssues.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    for (final entry in sortedFiles.take(5)) {
      final relativePath = entry.key.replaceFirst(RegExp(r'^.*lib/'), 'lib/');
      print(
        '${entry.value.length.toString().padLeft(3)} issues - $relativePath',
      );
    }

    final coveragePercent =
        ((1 - (totalIssues / (totalIssues + translationKeys.length))) * 100)
            .toStringAsFixed(1);
    print('\n📊 Estimated Translation Coverage: $coveragePercent%');

    if (double.parse(coveragePercent) >= 90) {
      print('🌟 GREAT! Your app has excellent translation coverage!');
    } else if (double.parse(coveragePercent) >= 70) {
      print('👍 GOOD! Your app has decent translation coverage.');
    } else {
      print('⚠️  WARNING: Your app needs more translation work.');
    }
  }
}

void main() async {
  await TranslationValidator.main();
}
