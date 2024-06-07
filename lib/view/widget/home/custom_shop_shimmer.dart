import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShopShimmer extends StatelessWidget {
  final Size size;
  const CustomShopShimmer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 5,
            (BuildContext context, int index) {
      return Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
            child: SizedBox(
              height: size.height * .15,
              width: size.width,
              child: Row(children: [
                imageShimmer(),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            rateTitleShimmer(),
                            SizedBox(
                              height: 8,
                            ),
                            addressShimmer(),
                            SizedBox(
                              height: 8,
                            ),
                            addressShimmer(),
                          ],
                        ),
                        Row(
                          children: [
                            rateTitleShimmer(),
                            SizedBox(
                              width: 4,
                            ),
                            rateShimmer()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const Divider(
            height: 6,
            thickness: 1,
          )
        ],
      );
    }));
  }

  Widget addressShimmer() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(50, 0, 0, 0),
      highlightColor: Color.fromARGB(106, 255, 255, 255),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Container(
          color: Color.fromARGB(50, 0, 0, 0),
          height: size.height * .018,
          width: size.width * .6,
        ),
      ),
    );
  }

  Widget rateTitleShimmer() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(50, 0, 0, 0),
      highlightColor: Color.fromARGB(176, 255, 255, 255),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Container(
          color: Color.fromARGB(50, 0, 0, 0),
          height: size.height * .018,
          width: size.width * .4,
        ),
      ),
    );
  }

  Widget rateShimmer() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(50, 0, 0, 0),
      highlightColor: Color.fromARGB(176, 255, 255, 255),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Container(
          color: Color.fromARGB(50, 0, 0, 0),
          height: size.height * .018,
          width: size.width * .2,
        ),
      ),
    );
  }

  Widget imageShimmer() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(50, 0, 0, 0),
      highlightColor: Color.fromARGB(176, 255, 255, 255),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          color: Color.fromARGB(50, 0, 0, 0),
          height: size.height * .15,
          width: size.width * .3,
        ),
      ),
    );
  }
}
