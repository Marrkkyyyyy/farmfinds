import 'package:ecommerce/view/widget/scanner/custom_title_head.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCharacteristics extends StatelessWidget {
  const CustomCharacteristics(
      {super.key,
      required this.titleHead,
      required this.iconHead,
      required this.harvestTime});
  final String titleHead;
  final IconData iconHead;
  final String harvestTime;
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
                  "Harvest Time",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                Expanded(
                  child: Text(
                    harvestTime,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
