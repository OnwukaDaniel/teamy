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
          style: bl.copyWith(fontWeight: FontWeight.w800),
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
              () {},
            ),
            8.h,
            card(
              'Doing',
              Icon(Icons.circle, color: Colors.yellowAccent),
              () {},
            ),
            8.h,
            card('Done', Icon(Icons.circle, color: Colors.green), () {}),
          ],
        ],
      ),
    );
  }

  Widget card(String title, Widget icon, Function() onTap) {
    return InkWell(
      onTap: () {},
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
}
