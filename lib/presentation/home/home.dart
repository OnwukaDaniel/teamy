import 'package:teamy/imports.dart';
import 'package:teamy/presentation/home/views/home_body.dart';

class Home extends StatelessWidget with ThemeHelper {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          body: HomeBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.createWorkspace(context),
            shape: CircleBorder(),
            backgroundColor: bl.color,
            child: Icon(Icons.add, color: bgColor),
          ),
        );
      },
    );
  }
}
