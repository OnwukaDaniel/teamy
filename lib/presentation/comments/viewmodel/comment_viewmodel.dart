import 'package:teamy/imports.dart';

class CommentViewModel extends BaseViewModel with ThemeHelper {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController editCommentController = TextEditingController();
  final List<String> _comments = [];
  late TaskData _currentTask;

  List<String> get comments => _comments;

  TaskData get currentTask => _currentTask;

  void setCurrentTask(TaskData task) {
    _currentTask = task;
    _comments.addAll(task.comments);
    fetchComments(task.id);
  }

  void fetchComments(String taskId) {
    setBusy(true);
    setBusy(false);
    notifyListeners();
  }

  void addComment(String taskId) {
    if (commentController.text.trim().isEmpty) return;
    commentController.clear();
    notifyListeners();
  }

  Future<void> editComment(String oldComment, String newComment) async {
    setBusy(true);
    final res = await WorkspaceRepo.editComment(
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

  void deleteComment(String commentId) {}

  void showEditDialog(BuildContext context, String comment) {
    editCommentController.text = comment;
    showDialog(
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
  }

  void showDeleteDialog(BuildContext context, String commentId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Comment'),
            content: const Text(
              'Are you sure you want to delete this comment?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  deleteComment(commentId);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    editCommentController.dispose();
    super.dispose();
  }
}
