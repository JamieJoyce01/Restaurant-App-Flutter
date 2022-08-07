import 'package:flutter/cupertino.dart';
import 'package:synoptic_restaurant_app/main_classes/account/account.dart';

class AccountProvider extends ChangeNotifier {
  late Account _currentAccount;

  Account get account => _currentAccount;

  //String get runningTotal => "£${_currentAccount.getCartTotal()}";

  setAccount(account) async {
    _currentAccount = await account;
    notifyListeners();
  }
}