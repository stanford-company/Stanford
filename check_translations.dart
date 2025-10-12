import 'dart:io';
import 'dart:convert';

void main() async {
  print('🔍 Checking translation coverage...\n');

  // Load translation files
  final enFile = File('assets/languages/en-US.json');
  final arFile = File('assets/languages/ar-SA.json');

  if (!enFile.existsSync() || !arFile.existsSync()) {
    print('❌ Translation files not found!');
    return;
  }

  final enContent =
      jsonDecode(await enFile.readAsString()) as Map<String, dynamic>;
  final arContent =
      jsonDecode(await arFile.readAsString()) as Map<String, dynamic>;

  print('📊 Translation Statistics:');
  print('   English keys: ${enContent.length}');
  print('   Arabic keys: ${arContent.length}');

  // Check for missing Arabic translations
  final missingInArabic = <String>[];
  for (final key in enContent.keys) {
    if (!arContent.containsKey(key)) {
      missingInArabic.add(key);
    }
  }

  // Check for missing English translations
  final missingInEnglish = <String>[];
  for (final key in arContent.keys) {
    if (!enContent.containsKey(key)) {
      missingInEnglish.add(key);
    }
  }

  if (missingInArabic.isEmpty && missingInEnglish.isEmpty) {
    print('✅ Perfect! All translations are synchronized.\n');
  } else {
    if (missingInArabic.isNotEmpty) {
      print('\n❌ Missing Arabic translations:');
      for (final key in missingInArabic) {
        print('   - "$key"');
      }
    }

    if (missingInEnglish.isNotEmpty) {
      print('\n❌ Missing English translations:');
      for (final key in missingInEnglish) {
        print('   - "$key"');
      }
    }
  }

  print('\n✅ Translation validation complete!');

  print('\n🎉 Translation check complete!');
  print(
    '📝 Coverage: ${((enContent.length == arContent.length) ? "100%" : "Partial")}',
  );
}
