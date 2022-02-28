import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class LoadingButton<T extends BaseViewModel> extends StatelessWidget {
  final String normalText;
  final String loadingText;
  final Function onClick;
  final T model;

  LoadingButton({
    this.model,
    this.normalText,
    this.loadingText,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<T>(
        builder: (BuildContext context, model, Widget child) {
          return MaterialButton(
            disabledColor: Colors.grey,
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).accentColor,
            onPressed: model.state == ViewState.Idle ? onClick : null,
            child: model.state == ViewState.Idle
                ? Text(
                    normalText.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Colors.grey[600],
                          ),
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          loadingText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
