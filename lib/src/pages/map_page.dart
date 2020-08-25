import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapPage extends StatelessWidget {
  final MapController map = MapController();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
             onPressed: (){
               map.move(scan.getLatLng(), 10);
             }
          )
        ],
      ),
      body: _createFlutterMap(scan),
    );
  }

  Widget _createFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _createMap(),
        _createMarker(scan),
      ],
    );
  }

  TileLayerOptions _createMap() {
    return TileLayerOptions(
      urlTemplate:'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoicmljYXJkb3RnMzQiLCJhIjoiY2tkdmJjYXN0MWFoeTMwbXB1ZG05NHZ5dyJ9.HaFI2JmFw4H0TbF9zvTPNA',
        'id': 'mapbox/streets-v11'
      }
    );
  }

  MarkerLayerOptions _createMarker(ScanModel scan) {
    return MarkerLayerOptions(
      markers: [
        Marker(
        width: 100,
        height: 100,
        point: scan.getLatLng(),
        builder: (BuildContext markerContext) => Container(
          child: Icon(Icons.location_on, size: 45, color: Theme.of(markerContext).primaryColor),
        )
      )
      ]
    );
  }
}