import 'package:ecommerce/view/widget/scanner/custom_title_head.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomScientificClassication extends StatelessWidget {
  const CustomScientificClassication(
      {super.key,
      required this.tagalogName,
      required this.botanicalName,
      required this.familyName,
      required this.titleHead,
      required this.iconHead});
  final String tagalogName;
  final String botanicalName;
  final String familyName;
  final String titleHead;
  final IconData iconHead;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Column(
        children: [
          CustomTitleHead(titleHead: titleHead, iconHead: iconHead),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(115, 235, 235, 235),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tagalog",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Expanded(
                  child: Text(
                    tagalogName,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Botanical",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Expanded(
                  child: Text(
                    botanicalName,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(115, 235, 235, 235),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Family",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Expanded(
                  child: Text(
                    familyName,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
