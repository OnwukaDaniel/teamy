import 'package:teamy/imports.dart';

class TasksScreen extends StatelessWidget with ThemeHelper {
  final String workspaceId;

  const TasksScreen({super.key, required this.workspaceId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkspaceViewmodel>.reactive(
      viewModelBuilder: () => WorkspaceViewmodel(),
      onViewModelReady: (viewModel) => viewModel.fetchTasks(workspaceId),
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: bgColor,
              elevation: 0,
              title: Text(
                'Tasks',
                style: tl.copyWith(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body:
                model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTaskSection(
                            title: 'To Do',
                            tasks: model.toDoTasks,
                            color: Colors.orange[100]!,
                          ),
                          const SizedBox(height: 24),
                          _buildTaskSection(
                            title: 'Doing',
                            tasks: model.doingTasks,
                            color: Colors.blue[100]!,
                          ),
                          const SizedBox(height: 24),
                          _buildTaskSection(
                            title: 'Expired',
                            tasks: model.expiredTasks,
                            color: Colors.red[400]!,
                          ),
                          const SizedBox(height: 24),
                          _buildTaskSection(
                            title: 'Done',
                            tasks: model.doneTasks,
                            color: Colors.green[100]!,
                          ),
                        ],
                      ),
                    ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await TaskHelper().createTask(context, workspaceId);
                model.fetchTasks(workspaceId);
              },
              shape: CircleBorder(),
              backgroundColor: bl.color,
              child: Icon(Icons.add, color: bgColor),
            ),
          ),
    );
  }

  Widget _buildTaskSection({
    required String title,
    required List<TaskData> tasks,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: tl.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (tasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'No tasks in $title',
              style: bm.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          )
        else
          ...tasks.map((task) => _buildTaskCard(task, color)),
      ],
    );
  }

  Widget _buildTaskCard(TaskData task, Color sectionColor) {
    DateTime? deadline;
    String formattedDeadline = '';
    try {
      deadline = DateTime.parse(task.deadline);
      formattedDeadline = DateFormat('yyyy-MM-dd').format(deadline);
    } catch (e) {
      formattedDeadline = task.deadline;
    }
    String tags = task.tags?.fold('', (a, b) => '$a, $b') ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardTheme,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.description,
                  style: bl.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Deadline: $formattedDeadline',
                  style: bs.copyWith(color: Colors.grey[600]),
                ),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'TAGS: $tags',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: bm.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: sectionColor.withAlpha(100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.edit, color: bl.color, size: 20),
          ),
        ],
      ),
    );
  }
}
