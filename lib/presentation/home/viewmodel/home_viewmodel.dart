import 'package:teamy/imports.dart';

class HomeViewmodel extends BaseViewModel {
  late BottomIcons selectedIcon;
  UserData? userData;
  List<WorkspaceData> workspaceList = [];
  final List<BottomIcons> bottomIcons = [
    BottomIcons(name: 'Home', asset: 'assets/home.svg'),
    BottomIcons(name: 'My Workspaces', asset: 'assets/workspaces.svg'),
  ];

  init() {
    selectedIcon = bottomIcons.first;
    getWorkspace();
  }

  setBottomIcon(BottomIcons input) {
    selectedIcon = input;
    notifyListeners();
  }

  fetchUserLocal() async {
    userData = await AuthRepo.getLocalUser();
  }

  getWorkspace() async {
    setBusy(true);
    final res = await WorkspaceRepo.getWorkSpaces();
    setBusy(false);
    if (res.status) {
      workspaceList = res.status as List<WorkspaceData>;
      notifyListeners();
    }
  }

  createWorkspace(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => CreateNewWorkspace()),
    );
  }
}
