import 'package:teamy/imports.dart';

class WorkspaceDashboard extends StatelessWidget
    with ThemeHelper, StaticWidgets {
  final WorkspaceData workspaceData;

  const WorkspaceDashboard(this.workspaceData, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WorkspaceViewmodel(),
      onViewModelReady: (model) => model.init(workspaceData),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            centerTitle: true,
            title: Text(
              workspaceData.name,
              style: bl.copyWith(fontWeight: FontWeight.w800),
            ),
            actions: [
              IconButton(
                onPressed: () => deleteWorkSpace(context, model),
                icon: Icon(Icons.delete_forever_outlined, color: bl.color),
              ),
              12.w,
            ],
          ),
          body: ListView(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(height: 120),
                  Image.asset(
                    workspaceData.asset,
                    width: size.width,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.white.withAlpha(70),
                    width: size.width,
                    height: 90,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    left: 1,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            workspaceData.asset,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              24.h,
              ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          workspaceData.name,
                          textAlign: TextAlign.center,
                          style: tl.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      12.h,
                      Text(
                        workspaceData.description,
                        textAlign: TextAlign.center,
                        style: bl,
                      ),
                      32.h,
                      Text(
                        'Lists',
                        style: bl.copyWith(fontWeight: FontWeight.w800),
                      ),
                      24.h,
                    ],
                  ),
                ),
                card(
                  'To Do-s',
                  Icon(Icons.circle_outlined, color: Colors.lightGreenAccent),
                  () => model.goToTasks(context),
                ),
                8.h,
                card(
                  'Doing',
                  Icon(Icons.circle, color: Colors.yellowAccent),
                  () => model.goToTasks(context),
                ),
                8.h,
                card(
                  'Expired',
                  Icon(Icons.circle, color: Colors.red),
                  () => model.goToTasks(context),
                ),
                8.h,
                card(
                  'Done',
                  Icon(Icons.circle, color: Colors.green),
                  () => model.goToTasks(context),
                ),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => TaskHelper().createTask(context, workspaceData.id),
            shape: CircleBorder(),
            backgroundColor: bl.color,
            child: Icon(Icons.add, color: bgColor),
          ),
        );
      },
    );
  }

  Widget card(String title, Widget icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            16.w,
            icon,
            12.w,
            Text(title, style: bm),
            Spacer(),
            Icon(Icons.arrow_forward_rounded, color: bl.color),
            16.w,
          ],
        ),
      ),
    );
  }

  deleteWorkSpace(BuildContext context, WorkspaceViewmodel model) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text('Delete Workspace', style: tm),
          content: Text(
            'Are you sure you want to delete this workspace?',
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
                await model.deleteWorkSpace(context);
                if (context.mounted) Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              child: Text('Delete', style: bm.copyWith(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
