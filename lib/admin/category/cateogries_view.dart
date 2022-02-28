import 'package:flutter/material.dart';
import 'package:grand_uae/admin/category/categories_model.dart';
import 'package:grand_uae/admin/model/category_response.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';
import 'package:grand_uae/util/strings.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Consumer<CategoriesModel>(
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
            itemCount: model.customerList.length,
            itemBuilder: (context, index) {
              Category category = model.customerList[index];
              return ListTile(
                title: Text(category.name.toHtmlUnescapeCapitalize()),
                trailing: IconButton(
                  onPressed: () {
                    model.deleteCategory(category);
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
