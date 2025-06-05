import 'package:teamy/imports.dart';
import 'package:teamy/presentation/create_workspace/view_model/create_workspace_viewmodel.dart';

class CreateNewWorkspace extends StatelessWidget with ThemeHelper {
  const CreateNewWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CreateWorkspaceViewmodel(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            centerTitle: true,
            title: Text(
              'Create Workspace',
              style: bl.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          body: Form(
            key: model.formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                input(
                  model,
                  controller: model.nameController,
                  textInputAction: TextInputAction.next,
                  hint: 'Workspace name',
                  validator: ValidatorService.validateName,
                ),
                16.h,
                input(
                  model,
                  controller: model.descriptionController,
                  textInputAction: TextInputAction.next,
                  hint: 'Workspace Description',
                  minLines: 5,
                  validator: ValidatorService.validateName,
                ),
                34.h,
                Row(
                  children: [
                    Text('Choose a Workspace Icon', style: bm),
                    12.w,
                    Text('(Optional)', style: bm.copyWith(color: Colors.grey)),
                  ],
                ),
                Wrap(
                  children:
                      model.icons.map((e) {
                        return InkWell(
                          onTap: () => model.selectIcon(e),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4,
                                ),
                                child: Image.asset(e, width: size.width * .42),
                              ),
                              if (model.icon == e)
                                Container(
                                  width: size.width * .42,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey.withAlpha(150),
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
                34.h,
                TextButton(
                  onPressed: () => model.createWorkSpace(context),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.appColor),
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
                              'Sign In',
                              style: bl.copyWith(color: Colors.white),
                            ),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget input(
    CreateWorkspaceViewmodel model, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    int minLines = 1,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hint != null) ...[Text(hint, style: bm), 12.h],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          minLines: minLines,
          maxLines: minLines,
          decoration: InputDecoration(
            focusedBorder: border(),
            filled: true,
            hintText: hint,
            fillColor: Colors.grey.withAlpha(40),
            border: border(),
            enabledBorder: border(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.withAlpha(40)),
    );
  }
}
