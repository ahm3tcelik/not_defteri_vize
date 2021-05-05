import 'package:flutter/material.dart';

extension LoadingExtensions on BuildContext {
  void loadingDialogOpen() {
    showDialog(context: this,
        builder: (context) => Center(child: CircularProgressIndicator()),
        barrierDismissible: false
    );
  }

  void loadingDialogClose() {
    Navigator.pop(this);
  }
}