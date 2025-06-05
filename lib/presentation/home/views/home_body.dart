import 'package:teamy/imports.dart';

class HomeBody extends StackedHookView<HomeViewmodel> with ThemeHelper {
  const HomeBody({super.key});

  @override
  Widget builder(BuildContext context, model) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'Workspace',
          style: tl.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body:
          model.workspaceList.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 8),
                      Image.asset(
                        'assets/empty_workspace.png',
                        width: size.width * .5,
                      ),
                      24.h,
                      Text(
                        'Welcome to Your Workspace',
                        style: tm.copyWith(fontWeight: FontWeight.w700),
                      ),
                      18.h,
                      Text(
                        "This is where your team's work comes to life. Start by creating your first list to organize tasks and projects.",
                        textAlign: TextAlign.center,
                        style: bl,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () => model.createWorkspace(context),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColor.appColor.withAlpha(70),
                          ),
                        ),
                        child:
                            model.isBusy
                                ? CircularProgressIndicator(color: Colors.white)
                                : Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Create your first workspace',
                                    style: bl.copyWith(color: Colors.white),
                                  ),
                                ),
                      ),
                      Spacer(flex: 8),
                    ],
                  ),
                ),
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('My Workspaces', style: tm),
                  ),
                  16.h,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemCount: model.workspaceList.length,
                      itemBuilder: (_, index) {
                        final data = model.workspaceList[index];
                        return workspaceCard(data, model);
                      },
                      separatorBuilder: (_, __) => 8.h,
                    ),
                  ),
                  kToolbarHeight.h,
                ],
              ),
    );
  }

  Widget workspaceCard(WorkspaceData data, HomeViewmodel model) {
    return Builder(
      builder: (context) {
        return Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () async {
              await model.viewWorkSpace(context, data);
              model.getWorkspace(); //refresh workspace
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: tm.copyWith(fontWeight: FontWeight.w800),
                        ),
                        16.h,
                        Text(
                          data.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: bs.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  16.w,
                  if (data.asset.isNotEmpty)
                    Expanded(child: Image.asset(data.asset)),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
