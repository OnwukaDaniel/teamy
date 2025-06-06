import 'package:teamy/imports.dart';

class HomeViewmodel extends BaseViewModel {
  final IAuthRepo authRepo = AuthRepo();
  late BottomIcons selectedIcon;
  UserData? userData;
  List<WorkspaceData> _workspaceList = [];
  final IWorkspaceRepository workspaceRepo = WorkspaceRepositoryImpl();

  List<WorkspaceData> get workspaceList => _workspaceList;
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
    userData = await authRepo.getLocalUser();
  }

  getWorkspace() async {
    setBusy(true);
    final res = await workspaceRepo.getWorkSpaces();
    setBusy(false);
    if (res.status) {
      _workspaceList.clear();
      _workspaceList = res.data as List<WorkspaceData>;
      notifyListeners();
    }
  }

  createWorkspace(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => CreateNewWorkspace()),
    );
    getWorkspace();
  }

  viewWorkSpace(BuildContext context, WorkspaceData data) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => WorkspaceDashboard(data)),
    );
  }
}
