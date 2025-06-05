import 'package:teamy/imports.dart';

class WorkspaceViewmodel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateControllerController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  DateTime? date;
  final formKey = GlobalKey<FormState>();
  List<String> tagList = [
    '#project',
    '#priority-high',
    '#wins',
    '#stage',
    '#customer',
    '#feature-request',
    '#job-to-be-done',
    '#commercial',
  ];
  List<String> _addedTagList = [];

  List<String> get addedTagList => _addedTagList;

  addToTagList(String input) {
    _addedTagList.add(input);
    notifyListeners();
  }

  createTask(BuildContext context, String id) async {
    if (!formKey.currentState!.validate()) return;
    if (date == null) return AppMessage.msg('Select Deadline');
    final description = descriptionController.text.trim();
    final comments = commentsController.text.trim();
    final taskData = TaskData(
      id: 'Task_${DateTime.now().toIso8601String()}',
      workspaceId: id,
      deadline: date!.toIso8601String(),
      description: description,
      comments: comments,
      status: TaskStatus.toDo.name,
      tags: addedTagList,
    );
    setBusy(true);
    final res = await WorkspaceRepo.createTask(taskData);
    setBusy(false);
    if (res.status) {
      AppMessage.msg(res.message, textColor: Colors.white, color: Colors.green);
      if (context.mounted) Navigator.pop(context);
    } else {
      AppMessage.msg(res.message);
    }
  }

  pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().copyWith(year: DateTime.now().year + 10),
    );
    if (date != null) {
      this.date = date;
      dateControllerController.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }
}
