import 'package:teamy/imports.dart';

class HomeViewmodel extends BaseViewModel {
  late BottomIcons selectedIcon;
  UserData? userData;
  List<WorkspaceData> workspaceList = [];
  final List<BottomIcons> bottomIcons = [
    BottomIcons(name: 'Home', asset: 'assets/home.svg'),
    BottomIcons(name: 'My Workspaces', asset: 'assets/workspaces.svg'),
  ];
  final List<TaskData> _tasks = [];

  List<TaskData> get tasks => _tasks;

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
      workspaceList = res.data as List<WorkspaceData>;
      _tasks.clear();
      for (WorkspaceData workspaceData in workspaceList) {
        getAllTasksFromAllWorkspaces(workspaceData);
      }
      notifyListeners();
    }
  }

  getAllTasksFromAllWorkspaces(WorkspaceData workspaceData) async {
    setBusy(true);
    final res = await WorkspaceRepo.getTasks(workspaceData.id);
    setBusy(false);
    if (res.status) {
      _tasks.addAll(res.data as List<TaskData>);
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

  viewWorkSpace(BuildContext context, WorkspaceData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => WorkspaceDashboard(data)),
    );
  }
}
