import 'package:teamy/imports.dart';
import 'package:teamy/presentation/home/views/home_body.dart';
import 'package:teamy/presentation/home/views/home_navigation_bar.dart';
import 'package:teamy/presentation/home/views/home_tasks_body.dart';

class Home extends StatelessWidget with ThemeHelper {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          body: Stack(
            children: [
              model.selectedIcon.name.toLowerCase() == 'home'
                  ? HomeBody()
                  : HomeTasksBody(),
              Positioned(bottom: 1, child: HomeNavigationBar()),
              Positioned(
                bottom: 16,
                right: 1,
                left: 1,
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Material(
                        borderRadius: BorderRadius.circular(600),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () => model.createWorkspace(context),
                          child: SvgPicture.asset('assets/add.svg', width: 60),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
