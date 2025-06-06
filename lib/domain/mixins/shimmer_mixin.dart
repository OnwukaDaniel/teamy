import 'package:teamy/imports.dart';

mixin ShimmerMixin {
  Widget shimmerCard({double height = 50}) {
    return Builder(
      builder: (context) {
        var size = MediaQuery.of(context).size;
        return Shimmer.fromColors(
          baseColor: Colors.grey.withAlpha(20),
          highlightColor: Colors.grey.withAlpha(40),
          child: Container(
            width: size.width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  Widget shimmer({double height = 50, double width = 50}) {
    return Builder(
      builder: (context) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.withAlpha(20),
          highlightColor: Colors.grey.withAlpha(40),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  Widget rowBoxesShimmer({
    double height = 30,
    double width = 30,
    int count = 15,
  }) {
    return SizedBox(
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(count, (e) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withAlpha(20),
              highlightColor: Colors.grey.withAlpha(40),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
