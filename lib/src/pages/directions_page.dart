import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class DirectionsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if ( !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if(scans.length == 0){
          return Center(child: Text('No hay información'));
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (DismissDirection direction){
              scansBloc.deleteScan(scans[i].id);
            },
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color:  Colors.white),
              title: Text(scans[i].valor),
              subtitle: Text('${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: (){
                utils.openScan(context, scans[i]);
              },
            ),
          )
        );
      },
    );
  }
}