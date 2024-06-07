import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomVegetableHead extends StatelessWidget {
  const CustomVegetableHead(
      {super.key,
      required this.englishName,
      required this.aka,
      required this.familyName});
  final String englishName;
  final String familyName;
  final String aka;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: GoogleFonts.manrope(letterSpacing: .7),
                    text: '',
                    children: [
                  TextSpan(
                      text: englishName,
                      style: GoogleFonts.manrope(
                        color: Colors.blueGrey,
                        fontSize: 20,
                      )),
                  TextSpan(
                      text: ", a species of",
                      style: GoogleFonts.manrope(
                          color: Colors.black54, fontSize: 14)),
                  const TextSpan(text: " "),
                  TextSpan(
                      text: familyName,
                      style: GoogleFonts.manrope(
                        color: Colors.blueGrey,
                        fontSize: 20,
                      )),
                ])),
            const SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(
                    style: GoogleFonts.manrope(letterSpacing: .7, fontSize: 14),
                    text: '',
                    children: [
                  TextSpan(
                      text: "Also known as: ",
                      style: GoogleFonts.manrope(
                        color: Colors.black54,
                      )),
                  const TextSpan(text: " "),
                  TextSpan(
                      text: aka,
                      style: GoogleFonts.manrope(
                        color: Colors.black,
                      )),
                ])),
          ]),
    );
  }
}
