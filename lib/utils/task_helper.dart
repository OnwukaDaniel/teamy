import 'package:teamy/imports.dart';

class TaskHelper with ThemeHelper, StaticWidgets {
  createTask(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ViewModelBuilder.reactive(
            viewModelBuilder: () => WorkspaceViewmodel(),
            builder: (context, model, _) {
              return AlertDialog(
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
                        controller: model.dateControllerController,
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
                        onPressed: () => model.createTask(context),
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
                                ? CircularProgressIndicator(color: Colors.white)
                                : Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Create Task',
                                    style: bl.copyWith(color: Colors.white),
                                  ),
                                ),
                      ),
                    ],
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
