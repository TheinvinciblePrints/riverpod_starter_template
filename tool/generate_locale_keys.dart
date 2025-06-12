import 'dart:convert';
import 'dart:io';

void main() {
  const inputPath = 'assets/translations/en.json';
  const outputPath = 'lib/generated/locale_keys.g.dart';

  final file = File(inputPath);
  final jsonMap = json.decode(file.readAsStringSync());

  final buffer = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln('// ignore_for_file: constant_identifier_names\n')
    ..writeln('abstract class LocaleKeys {');

  void generateKeys(Map<String, dynamic> map, [String prefix = '']) {
    map.forEach((key, value) {
      final fullKey = prefix.isEmpty ? key : '$prefix.$key';
      if (value is Map<String, dynamic>) {
        generateKeys(value, fullKey);
      } else {
        final constName = fullKey.replaceAll('.', '_');
        buffer.writeln("  static const $constName = '$fullKey';");
      }
    });
  }

  generateKeys(jsonMap);
  buffer.writeln('}');

  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsStringSync(buffer.toString());

  print('✅ Locale keys generated at $outputPath');
}
