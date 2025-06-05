import 'package:teamy/imports.dart';

class HomeNavigationBar extends StackedHookView<HomeViewmodel>
    with ThemeHelper {
  const HomeNavigationBar({super.key});

  @override
  Widget builder(BuildContext context, model) {
    final size = MediaQuery.of(context).size;
    return Padding(
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
    );
  }
}
