import 'package:teamy/imports.dart';

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
              Positioned(
                bottom: 1,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Material(
                    borderRadius: BorderRadius.circular(64),
                    clipBehavior: Clip.hardEdge,
                    color: cardColor,
                    child: SizedBox(
                      width: size.width - 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            model.bottomIcons.map((e) {
                              return Expanded(
                                child: Container(
                                  color:
                                      model.selectedIcon == e
                                          ? AppColor.appColor.withAlpha(200)
                                          : null,
                                  child: InkWell(
                                    onTap: () => model.setBottomIcon(e),
                                    child: Column(
                                      children: [
                                        8.h,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                          ),
                                          child: SvgPicture.asset(
                                            e.asset,
                                            width: 20,
                                            color:
                                                model.selectedIcon == e
                                                    ? Colors.white
                                                    : bl.color,
                                          ),
                                        ),
                                        3.h,
                                        Text(
                                          e.name,
                                          style: bm.copyWith(
                                            fontWeight:
                                                model.selectedIcon == e
                                                    ? FontWeight.w800
                                                    : null,
                                            color:
                                                model.selectedIcon == e
                                                    ? Colors.white
                                                    : bl.color,
                                          ),
                                        ),
                                        8.h,
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => CreateNewWorkspace(),
                              ),
                            );
                          },
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
