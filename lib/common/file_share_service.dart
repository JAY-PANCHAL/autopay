import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart';

class FileShareService {
  static Future<void> shareFiles({required String excelPath, required String pdfPath}) async {
    final excelFile = File(excelPath);
    final pdfFile = File(pdfPath);

    List<XFile> filesToShare = [];

    if (await excelFile.exists()) {
      filesToShare.add(XFile(excelFile.path, name: basename(excelFile.path)));
    }
    if (await pdfFile.exists()) {
      filesToShare.add(XFile(pdfFile.path, name: basename(pdfFile.path)));
    }

    if (filesToShare.isEmpty) {
      print("No files found to share.");
      return;
    }

    final params = ShareParams(
      text: 'Milk Collection Reports (Excel + PDF)',
      files: filesToShare,
      subject: 'Milk Report Export',
    );

    final result = await SharePlus.instance.share(params);

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing!');
    } else if (result.status == ShareResultStatus.dismissed) {
      print('Share dismissed.');
    } else {
      print('Share failed.');
    }
  }
}
