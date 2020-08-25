import 'dart:async';

import 'package:qrreaderapp/src/bloc/validators.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = new ScansBloc._internal();

    factory ScansBloc(){
      return _singleton;
    }
    ScansBloc._internal(){
      obtenerScans();
      //Obtener Scans de la base de datos
    }
    final _scansController = StreamController<List<ScanModel>>.broadcast();
    Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
    Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

    dispose() {
      _scansController?.close();
    }

    addScan(ScanModel scan) async {
      await DBProvider.db.nuevoScan(scan);
      obtenerScans();
    }

    obtenerScans() async {
      _scansController.sink.add(await DBProvider.db.getAllScans());
    }

    deleteScan(int id) async {
      await DBProvider.db.deleteScan(id);
      obtenerScans();
    }

    void deleteAllScan() async {
      await DBProvider.db.deleteAll();
      obtenerScans();
    }
}