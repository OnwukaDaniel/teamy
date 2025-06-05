import 'package:teamy/imports.dart';

class HomeTasksBody extends StackedHookView<HomeViewmodel> with ThemeHelper {
  const HomeTasksBody({super.key});

  @override
  Widget builder(BuildContext context, model) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'All Tasks',
          style: tl.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        children:
            model.tasks.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: TasksScreen(
                  workspaceId: '',
                ).buildTaskCard(e, Colors.red[300]!, WorkspaceViewmodel()),
              );
            }).toList(),
      ),
    );
  }
}
