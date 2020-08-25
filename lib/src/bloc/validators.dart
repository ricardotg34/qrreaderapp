import 'dart:async';

import 'package:qrreaderapp/src/models/scan_model.dart';

class Validators {
  //Recibe un a lista de ScanModel y la salida tambien será un list de ScanMode
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    //Lista de scans
    handleData: ( scans, sink){
      final geoScans = scans.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScans);
    }
  );

  //Recibe un a lista de ScanModel y la salida tambien será un list de ScanMode
  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    //Lista de scans
    handleData: ( scans, sink){
      final geoScans = scans.where((s) => s.tipo == 'http').toList();
      sink.add(geoScans);
    }
  );
}