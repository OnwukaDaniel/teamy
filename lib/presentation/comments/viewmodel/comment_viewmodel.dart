import 'package:teamy/imports.dart';

class CommentViewModel extends BaseViewModel {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController editCommentController = TextEditingController();
  final List<String> _comments = [];
  TaskData? _currentTask;

  List<String> get comments => _comments;

  TaskData? get currentTask => _currentTask;

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

  void editComment(String commentId, String newComment) {}

  void deleteComment(String commentId) {}

  // Show edit dialog
  void showEditDialog(BuildContext context, String comment) {
    editCommentController.text = comment;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Comment'),
            content: TextField(
              controller: editCommentController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter your comment...',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  editComment(comment, editCommentController.text.trim());
                  Navigator.pop(context);
                },
                child: const Text('Save'),
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
