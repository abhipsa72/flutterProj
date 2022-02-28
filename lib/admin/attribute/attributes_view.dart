import 'package:flutter/material.dart';
import 'package:grand_uae/admin/attribute/attributes_model.dart';
import 'package:grand_uae/admin/model/attributes_response.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class AttributesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attributes'),
      ),
      body: Consumer<AttributesModel>(
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
            itemCount: model.attributes.length,
            itemBuilder: (context, index) {
              Attribute attribute = model.attributes[index];
              return ListTile(
                title: Text(attribute.name),
                trailing: IconButton(
                  onPressed: () {
                    model.deleteAttribute(attribute);
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
