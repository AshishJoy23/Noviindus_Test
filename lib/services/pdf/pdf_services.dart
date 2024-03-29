import 'dart:developer';
import 'dart:io';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfServices {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    var dir = await getTemporaryDirectory();
    log(dir.toString());
    var filePath = "${dir.path}/$name";
    final file = File(filePath);
    log(file.toString());
    await file.writeAsBytes(bytes);
    //await OpenDocument.openDocument(filePath: filePath);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    log(url);
    log('opening');
    await OpenDocument.openDocument(filePath: url);
    //OpenResult open = await OpenFile.open(url);
    //log(open.toString());
  }
}
