import 'package:teamy/imports.dart';

class CreateWorkspaceViewmodel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String _icon = '';
  final formKey = GlobalKey<FormState>();

  String get icon => _icon;

  List<String> icons = [
    'assets/icon1.png',
    'assets/icon2.png',
    'assets/icon3.png',
    'assets/icon4.png',
    'assets/icon5.png',
  ];

  selectIcon(String e) {
    _icon = e;
    notifyListeners();
  }

  createWorkSpace(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    setBusy(true);
    final res = await WorkspaceRepo.createWorkSpace(
      nameController.text.trim(),
      descriptionController.text.trim(),
      asset: _icon,
    );
    setBusy(false);
    if (res.status && context.mounted) {
      AppMessage.msg(res.message, textColor: Colors.white, color: Colors.green);
      return Navigator.pop(context);
    } else {
      AppMessage.msg(res.message);
    }
  }
}
