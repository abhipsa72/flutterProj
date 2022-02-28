import 'package:flutter/material.dart';
import 'package:grand_uae/admin/manufacture/manufracture_model.dart';
import 'package:grand_uae/admin/model/manufacture_response.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class ManufactureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manufacturers'),
      ),
      body: Consumer<ManufacturesModel>(
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return Center(
              child: Text(model.errorMessage),
            );
          }
          return ListView.builder(
            itemCount: model.manufacturers.length,
            itemBuilder: (context, index) {
              Manufacturer manufacturer = model.manufacturers[index];
              return ListTile(
                title: Text(manufacturer.name),
                trailing: IconButton(
                  onPressed: () {
                    model.deleteManufacture(manufacturer);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
