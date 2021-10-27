import 'package:flutter/cupertino.dart';

class UiState extends ChangeNotifier {
  bool _isAdmin = true;
  Widget _centerWidget = const Text('Welcome');

  //GETTERS
  bool get isAdmin => _isAdmin;
  Widget get centerWidget => _centerWidget;

//SETTERS
  void setIsAdmin({required bool isAdmin}) {
    _isAdmin = isAdmin;
    notifyListeners(); //uncomment this if admin switching is not happening
  }

  void setCenterWidget(Widget widget) {
    _centerWidget = widget;
    notifyListeners();
  }
}
