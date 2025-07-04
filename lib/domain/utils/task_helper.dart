import 'package:teamy/imports.dart';

class TaskHelper with ThemeHelper, StaticWidgets {
  createTask(
    BuildContext context,
    String workspaceId, {
    TaskData? taskData,
  }) async {
    final size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ViewModelBuilder.reactive(
            viewModelBuilder: () => WorkspaceViewmodel(),
            onViewModelReady: (model) => model.initEditingTaskData(taskData),
            builder: (context, model, _) {
              return AlertDialog(
                backgroundColor: bgColor,
                title: Text(
                  'Create New Task',
                  style: tl.copyWith(fontWeight: FontWeight.w800),
                ),
                content: SizedBox(
                  width: size.width * .88,
                  child: Form(
                    key: model.formKey,
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
                          subHint: '*',
                          textInputAction: TextInputAction.next,
                          controller: model.descriptionController,
                          validator: ValidatorService.validateName,
                        ),
                        input(
                          hint: 'Deadline',
                          subHint: '*',
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          controller: model.dateControllerController,
                          suffix: Icon(Icons.date_range, color: bl.color),
                          onTap: () => model.pickDate(context),
                        ),
                        input(
                          hint: 'Comments',
                          subHint: '(Optional)',
                          textInputAction: TextInputAction.next,
                          minLines: 5,
                          controller: model.commentsController,
                        ),
                        16.h,
                        if (taskData != null) ...[
                          16.h,
                          Text('Mark as:', style: bm),
                          12.h,
                          Wrap(
                            children:
                            TaskStatus.values.map((e) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: TextButton(
                                  onPressed: () => model.updateStatus(e),
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      model.editingTaskData?.status == e.name
                                          ? Colors.green
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    e.name,
                                    style: bm.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                        Text('Tags', style: bm),
                        12.h,
                        Wrap(
                          children:
                              model.tagList.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
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
                                      style: bm.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        TextButton(
                          onPressed: () async {
                            await model.createTask(context, workspaceId);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColor.appColor,
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child:
                              model.isBusy
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      '${taskData == null ? 'Create' : 'Edit'} Task',
                                      style: bl.copyWith(color: Colors.white),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
    String? subHint,
    Widget? suffix,
    String? Function(String?)? validator,
    Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.h,
        if (hint != null) ...[
          Row(
            children: [
              Text(hint, style: bm),
              6.w,
              Text(subHint ?? '', style: bm.copyWith(color: Colors.grey)),
            ],
          ),
          12.h,
        ],
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
