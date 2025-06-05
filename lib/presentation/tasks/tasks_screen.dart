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
              actions: [
                IconButton(
                  onPressed: () => showInfo(context),
                  icon: Icon(Icons.info_outline_rounded, color: bl.color),
                ),
                12.w,
              ],
            ),
            body:
                model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTaskSection(
                            title: 'To Do',
                            tasks: model.toDoTasks,
                            color: Colors.orange[100]!,
                            model: model,
                          ),
                          const SizedBox(height: 24),
                          buildTaskSection(
                            title: 'Doing',
                            tasks: model.doingTasks,
                            color: Colors.blue[100]!,
                            model: model,
                          ),
                          const SizedBox(height: 24),
                          buildTaskSection(
                            title: 'Expired',
                            tasks: model.expiredTasks,
                            color: Colors.red[400]!,
                            model: model,
                          ),
                          const SizedBox(height: 24),
                          buildTaskSection(
                            title: 'Done',
                            tasks: model.doneTasks,
                            color: Colors.green[100]!,
                            model: model,
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

  showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardTheme,
          title: Row(
            children: [
              Spacer(flex: 5),
              Text('Tips', style: tl.copyWith(fontWeight: FontWeight.w900)),
              Spacer(flex: 3),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: bl.color),
              ),
            ],
          ),
          content: Text(
            'Swipe task card to the right to delete task',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget buildTaskSection({
    required String title,
    required List<TaskData> tasks,
    required Color color,
    required WorkspaceViewmodel model,
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
          ...tasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: buildTaskCard(task, color, model),
            ),
          ),
      ],
    );
  }

  Widget buildTaskCard(
    TaskData task,
    Color sectionColor,
    WorkspaceViewmodel model,
  ) {
    DateTime? deadline;
    String formattedDeadline = '';
    try {
      deadline = DateTime.parse(task.deadline);
      formattedDeadline = DateFormat('yyyy-MM-dd').format(deadline);
    } catch (e) {
      formattedDeadline = task.deadline;
    }
    String tags = task.tags?.fold('', (a, b) => '$a, $b') ?? '';

    return Slidable(
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => model.deleteTask(task.id, workspaceId),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.hardEdge,
        child: Builder(
          builder: (context) {
            return InkWell(
              onTap: () => model.goToComments(context, task),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardTheme.withAlpha(200),
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
                        mainAxisSize: MainAxisSize.min,
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
                    Builder(
                      builder: (context) {
                        return Material(
                          borderRadius: BorderRadius.circular(8),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () async {
                              await TaskHelper().createTask(
                                context,
                                task.workspaceId,
                                taskData: task,
                              );
                              model.fetchTasks(workspaceId);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: sectionColor.withAlpha(100),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: bl.color,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
