import 'package:teamy/imports.dart';

class HomeViewmodel extends BaseViewModel {
  late BottomIcons selectedIcon;
  UserData? userData;
  final List<BottomIcons> bottomIcons = [
    BottomIcons(name: 'Home', asset: 'assets/home.svg'),
    BottomIcons(name: 'My Workspaces', asset: 'assets/workspaces.svg'),
  ];

  init() {
    selectedIcon = bottomIcons.first;
  }

  setBottomIcon(BottomIcons input) {
    selectedIcon = input;
    notifyListeners();
  }

  fetchUserLocal() async {
    userData = await AuthRepo.getLocalUser();
  }
}