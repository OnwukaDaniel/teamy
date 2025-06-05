import 'dart:ui';

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
                8.h,
                card('Expired', Icon(Icons.circle, color: Colors.red), () {}),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => createTask(context, model),
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

  createTask(BuildContext context, WorkspaceViewmodel model) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: bgColor,
            title: Text(
              'Create New Task',
              style: tl.copyWith(fontWeight: FontWeight.w800),
            ),
            content: SizedBox(
              width: size.width * .88,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'FIll in the details to create a task',
                    style: bl.copyWith(fontWeight: FontWeight.w800),
                  ),
                  36.h,
                  input(
                    hint: 'Description',
                    textInputAction: TextInputAction.next,
                    controller: model.descriptionController,
                    validator: ValidatorService.validateName,
                  ),
                  input(
                    hint: 'Deadline',
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    suffix: Icon(Icons.date_range, color: bl.color),
                    onTap: () => model.pickDate(context),
                  ),
                  input(
                    hint: 'Comments',
                    textInputAction: TextInputAction.next,
                    minLines: 5,
                    controller: model.commentsController,
                  ),
                  16.h,
                  Text('Tags', style: bm),
                  12.h,
                  Wrap(
                    children:
                        model.tagList.map((e) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: TextButton(
                              onPressed: () => model.addToTagList(e),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  model.addedTagList.contains(e)
                                      ? AppColor.appColor
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                e,
                                style: bm.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget input({
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool readOnly = false,
    int minLines = 1,
    String? hint,
    Widget? suffix,
    String? Function(String?)? validator,
    Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.h,
        if (hint != null) ...[Text(hint, style: bm), 12.h],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          readOnly: readOnly,
          validator: validator,
          minLines: minLines,
          onTap: onTap,
          maxLines: minLines,
          decoration: InputDecoration(
            focusedBorder: border(),
            filled: true,
            hintText: hint,
            suffixIcon: suffix,
            fillColor: Colors.grey.withAlpha(40),
            border: border(),
            enabledBorder: border(),
          ),
        ),
      ],
    );
  }
}
