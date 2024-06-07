import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAmountPayable extends StatelessWidget {
  CustomAmountPayable({
    super.key,
    required this.totalQuantity,
    required this.totalAmountPayable,
    required this.text,
    required this.function,
    this.color = const Color.fromARGB(75, 34, 34, 34),
    this.driver = "",
    this.dateReceived = "",
    required this.payableText,
  });
  final int totalQuantity;
  final int totalAmountPayable;
  final String text;
  final Function function;
  final Color color;
  final String driver;
  final String dateReceived;
  final String payableText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headline5,
                        text: '',
                        children: [
                      TextSpan(
                          text: "${totalQuantity} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600)),
                      const TextSpan(text: " "),
                      TextSpan(
                          text: totalQuantity == 1 ? "item" : "items",
                          style: Theme.of(context).textTheme.headline5),
                    ])),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headline5,
                        text: '',
                        children: [
                      TextSpan(
                          text: "$payableText:",
                          style: Theme.of(context).textTheme.headline5),
                      const TextSpan(text: " "),
                      TextSpan(
                          text: "₱${totalAmountPayable}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600)),
                    ])),
              ],
            ),
            const Divider(
              height: 20,
            ),
            driver == ""
                ? SizedBox()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.truck,
                            color: Colors.teal,
                            size: 14,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: dateReceived != "null"
                                ? RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(fontSize: 14),
                                        text: '',
                                        children: [
                                        TextSpan(
                                            text: "Parcel has been delivered. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.teal)),
                                      ]))
                                : RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(fontSize: 14),
                                        text: '',
                                        children: [
                                        TextSpan(
                                            text:
                                                "Parcel is out for delivery. ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.teal)),
                                        TextSpan(text: "Rider: "),
                                        TextSpan(text: driver),
                                      ])),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                    ],
                  ),
            GestureDetector(
              onTap: () {
                function();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: const Color.fromARGB(206, 255, 255, 255),
                        fontSize: 16,
                      ),
                ),
              ),
            )
          ]),
        ),
        SpacerWidget(
          color: Color.fromARGB(12, 0, 0, 0),
        )
      ],
    );
  }
}
