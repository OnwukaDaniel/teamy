import 'package:teamy/imports.dart';

class WorkspaceDashboard extends StatelessWidget with ThemeHelper {
  final WorkspaceData workspaceData;

  const WorkspaceDashboard(this.workspaceData, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          workspaceData.name,
          style: tl.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        //padding: EdgeInsets.all(16),
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
        ],
      ),
    );
  }
}
