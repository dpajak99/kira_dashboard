import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class CustomFile extends Equatable {
  final int size;
  final String name;
  final String content;
  final String? extension;

  const CustomFile({
    required this.size,
    required this.name,
    required this.content,
    required this.extension,
  });

  factory CustomFile.fromPlatformFile(PlatformFile platformFile) {
    final List<int> fileBytes = platformFile.bytes ?? List<int>.empty();
    return CustomFile(
      name: platformFile.name,
      size: platformFile.size,
      extension: platformFile.extension,
      content: String.fromCharCodes(fileBytes),
    );
  }

  static Future<CustomFile> fromHtmlFile(html.File htmlFile) async {
    final Completer<CustomFile> fileCompleter = Completer<CustomFile>();
    final html.FileReader htmlFileReader = html.FileReader()..readAsText(htmlFile);
    final StreamSubscription<dynamic> fileUploadStream = htmlFileReader.onLoadEnd.listen((_) {
      String result = htmlFileReader.result.toString();
      CustomFile kiraDropzoneFileModel = CustomFile(
        name: htmlFile.name,
        size: htmlFile.size,
        extension: htmlFile.name.split('.').last,
        content: result,
      );
      fileCompleter.complete(kiraDropzoneFileModel);
    });
    CustomFile kiraDropzoneFileModel = await fileCompleter.future;
    await fileUploadStream.cancel();
    return kiraDropzoneFileModel;
  }

  String get sizeString {
    assert(size >= 0, 'File size must be greater than or equal to 0');
    List<String> siSuffixes = <String>['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int unitIndex = (log(size) / log(1024)).floor();
    num unitValue = size / pow(1024, unitIndex);
    String unitString = unitValue.toStringAsFixed(1);
    if (unitValue.toStringAsFixed(1).endsWith('.0')) {
      unitString = unitValue.toInt().toString();
    }
    return '$unitString ${siSuffixes[unitIndex]}';
  }

  @override
  List<Object?> get props => <Object?>[name, extension, content, size];
}
