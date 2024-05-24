import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

//! The UserProvider class manages the state of the user.
class UserProvider with ChangeNotifier {
  UserModel? _user;             //! Private variable to store the user data.
  final UserService userService; //! Dependency on UserService.

  //! Constructor to initialize the UserService.
  UserProvider({required this.userService});

  //! Getter to retrieve the user data.
  UserModel? get user => _user;

  //! Method to fetch user data and update the state.
  Future<UserModel?> fetchUser() async {
    if (kDebugMode) {
      print('UserProvider: Fetching user');
    }
    _user = await userService.fetchUser();
    notifyListeners();               //! Notifying listeners about the state change.
    if (kDebugMode) {
      print('UserProvider: Fetched user $_user');
    }
    return _user;
    // notifyListeners();               //! Notifying listeners about the state change.
  }
}