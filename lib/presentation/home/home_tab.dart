import 'package:teamy/imports.dart';

class HomeTab extends StatelessWidget with ThemeHelper {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.fetchUserLocal(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          body: ListView(
            children: [
              (kToolbarHeight * .5).h,
              Text('Hello ')
            ],
          ),
        );
      }
    );
  }
}