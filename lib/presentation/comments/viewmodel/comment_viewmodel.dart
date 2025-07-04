import 'package:teamy/imports.dart';

class CommentViewModel extends BaseViewModel with ThemeHelper {
  final IWorkspaceRepository workspaceRepo = WorkspaceRepositoryImpl();

  final commentController = TextEditingController();
  final editCommentController = TextEditingController();
  final List<String> _comments = [];
  late TaskData _currentTask;

  List<String> get comments => _comments;

  TaskData get currentTask => _currentTask;

  void setCurrentTask(TaskData task) {
    _currentTask = task;
    _comments.addAll(task.comments);
    getAndSetAllComments();
  }

  fetchComments(String taskId) async {
    setBusy(true);
    final res = await workspaceRepo.getTasks(_currentTask.workspaceId);
    setBusy(false);
    if (res.status) {
      final tasks = res.data as List<TaskData>;
      final filter = tasks.where((e) => e.id == _currentTask.id).toList();
      if (filter.isNotEmpty) _currentTask = filter.first;
      getAndSetAllComments();
    } else {
      AppMessage.msg(res.message);
    }
  }

  getAndSetAllComments() {
    _comments.clear();
    _comments.addAll(_currentTask.comments);
    notifyListeners();
  }

  addComment(String taskId) async {
    if (commentController.text.trim().isEmpty) return;
    final comment = commentController.text.trim();
    setBusy(true);
    final res = await workspaceRepo.addComment(_currentTask, comment);
    commentController.clear();
    setBusy(false);
    if (res.status) {
      AppMessage.msg(res.message, textColor: Colors.white, color: Colors.green);
    } else {
      AppMessage.msg(res.message);
    }
    fetchComments(_currentTask.id);
  }

  editComment(String oldComment, String newComment) async {
    setBusy(true);
    final res = await workspaceRepo.editComment(
      _currentTask,
      oldComment,
      newComment,
    );
    setBusy(false);
    if (res.status) {
      AppMessage.msg(res.message, textColor: Colors.white, color: Colors.green);
    } else {
      AppMessage.msg(res.message);
    }
  }

  deleteComment(String comment) async {
    setBusy(true);
    final res = await workspaceRepo.deleteComment(_currentTask, comment);
    setBusy(false);
    if (res.status) {
      AppMessage.msg(res.message, textColor: Colors.white, color: Colors.green);
    } else {
      AppMessage.msg(res.message);
    }
  }

  showEditDialog(BuildContext context, String comment) async {
    editCommentController.text = comment;
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit Comment', style: tl),
            backgroundColor: bgColor,
            content: TextField(
              controller: editCommentController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Enter your comment...',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                child: Text('Cancel', style: bm.copyWith(color: Colors.white)),
              ),
              TextButton(
                onPressed: () async {
                  await editComment(comment, editCommentController.text.trim());
                  if (context.mounted) Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                child: Text('Save', style: bm.copyWith(color: Colors.white)),
              ),
            ],
          ),
    );
    fetchComments(_currentTask.id);
  }

  showDeleteDialog(BuildContext context, String commentId) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: bgColor,
            title: Text('Delete Comment', style: tm),
            content: Text(
              'Are you sure you want to delete this comment?',
              style: bl,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                ),
                child: Text('Cancel', style: bm.copyWith(color: Colors.white)),
              ),
              TextButton(
                onPressed: () async {
                  await deleteComment(commentId);
                  if (context.mounted) Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                child: Text('Delete', style: bm.copyWith(color: Colors.white)),
              ),
            ],
          ),
    );
    fetchComments(_currentTask.id);
  }

  @override
  void dispose() {
    commentController.dispose();
    editCommentController.dispose();
    super.dispose();
  }
}
