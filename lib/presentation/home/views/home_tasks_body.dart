import 'package:teamy/imports.dart';

class HomeTasksBody extends StatelessWidget with ThemeHelper {
  const HomeTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'ALl Tasks',
          style: tl.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
