import 'package:calculater_app/utils/shr_helper.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier{

  bool isLight = false;

  Future<void> themeData()
  async {
    ShareHelper shr = ShareHelper();
    bool? isTheme = await shr.getTheme();
    isLight = isTheme??true;
    notifyListeners();
  }

}