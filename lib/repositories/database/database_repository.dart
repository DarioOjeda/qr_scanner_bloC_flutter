import 'package:qr_scanner_sqlite/models/scan_model.dart';

abstract class DatabaseRepository {

  Future<List<ScanModel>> loadAllScanner();

  Future<void> insertNewValue(String tipo, String valor);


}