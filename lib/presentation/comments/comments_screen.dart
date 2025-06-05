import 'package:teamy/imports.dart';

class CommentsScreen extends StatelessWidget with ThemeHelper {
  final TaskData taskData;

  const CommentsScreen({super.key, required this.taskData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentViewModel>.reactive(
      viewModelBuilder: () => CommentViewModel(),
      onViewModelReady: (viewModel) => viewModel.setCurrentTask(taskData),
      builder:
          (context, viewModel, child) => Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: bgColor,
              elevation: 1,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments',
                    style: tm.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    taskData.description,
                    style: bs.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                // Task Info Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.withAlpha(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.task_alt,
                            color: Colors.blue[600],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              taskData.description,
                              style: bl.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Deadline: ${_formatDate(taskData.deadline)}',
                            style: bs.copyWith(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                taskData.status,
                              ).withAlpha(50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              taskData.status.toUpperCase(),
                              style: ll.copyWith(
                                color: _getStatusColor(taskData.status),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Comments Section
                Expanded(
                  child:
                      viewModel.isBusy
                          ? const Center(child: CircularProgressIndicator())
                          : viewModel.comments.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No comments yet',
                                  style: bl.copyWith(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Be the first to add a comment',
                                  style: bs.copyWith(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: viewModel.comments.length,
                            itemBuilder: (context, index) {
                              final comment = viewModel.comments[index];
                              return _buildCommentCard(
                                context,
                                comment,
                                viewModel,
                              );
                            },
                          ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[100],
                        child: Icon(Icons.person, color: Colors.blue[600]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: viewModel.commentController,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue[600]!),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => viewModel.addComment(taskData.id),
                        icon: Icon(Icons.send, color: Colors.blue[600]),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildCommentCard(
    BuildContext context,
    String comment,
    CommentViewModel viewModel,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardTheme,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.person, color: Colors.blue[600], size: 20),
              ),
             12.w,
              Expanded(child: Text(comment, style: bm)),
              12.w,
              IconButton(
                onPressed:
                    () => viewModel.showDeleteDialog(context, comment),
                icon: const Icon(Icons.delete_outline),
                iconSize: 20,
                color: Colors.red[600],
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
              IconButton(
                onPressed: () => viewModel.showEditDialog(context, comment),
                icon: const Icon(Icons.edit_outlined),
                iconSize: 20,
                color: Colors.blue[600],
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'todo':
        return Colors.red;
      case 'doing':
        return Colors.blue;
      case 'done':
        return Colors.green;
      case 'expired':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
