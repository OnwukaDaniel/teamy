import 'package:teamy/imports.dart';

class HomeViewmodel extends BaseViewModel {
  late BottomIcons selectedIcon;
  final List<BottomIcons> bottomIcons = [
    BottomIcons(name: 'Home', asset: 'assets/home.svg'),
    //BottomIcons(name: 'Home', asset: 'assets/add.svg'),
    BottomIcons(name: 'My Workspaces', asset: 'assets/workspaces.svg'),
  ];

  init() {
    selectedIcon = bottomIcons.first;
  }

  setBottomIcon(BottomIcons input) {
    selectedIcon = input;
    notifyListeners();
  }

  fetchUserLocal() {
    final user = res.data as UserData;
    final jsonString = LocalStorage.getStringList(Preferences.userJson);
    jsonString.add(jsonEncode(user));
  }
}