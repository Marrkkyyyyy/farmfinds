import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductShimmer extends StatelessWidget {
  final Size size;
  const CustomProductShimmer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Shimmer.fromColors(
                baseColor: Color.fromARGB(50, 0, 0, 0),
                highlightColor: Color.fromARGB(176, 255, 255, 255),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Container(
                    color: Color.fromARGB(50, 0, 0, 0),
                    height: size.height * .195,
                    width: size.width * 1,
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Shimmer.fromColors(
                  baseColor: Color.fromARGB(50, 0, 0, 0),
                  highlightColor: Color.fromARGB(176, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(50, 0, 0, 0),
                      height: size.height * .016,
                      width: size.width * .44,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Shimmer.fromColors(
                  baseColor: Color.fromARGB(50, 0, 0, 0),
                  highlightColor: Color.fromARGB(176, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(50, 0, 0, 0),
                      height: size.height * .016,
                      width: size.width * .44,
                    ),
                  ),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Shimmer.fromColors(
                baseColor: Color.fromARGB(50, 0, 0, 0),
                highlightColor: Color.fromARGB(176, 255, 255, 255),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Container(
                    color: Color.fromARGB(50, 0, 0, 0),
                    height: size.height * .016,
                    width: size.width * .25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
