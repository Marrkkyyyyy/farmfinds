import 'package:flutter/material.dart';

class CustomInfoOrderDetails extends StatelessWidget {
  const CustomInfoOrderDetails(
      {super.key,
      required this.merchandiseSubtotal,
      required this.shippingFee,
      required this.orderTotal,
      required this.orderID,
      required this.date,
      this.shippedDate = "",
      this.dateReceived = ""});
  final int merchandiseSubtotal;
  final String shippingFee;
  final int orderTotal;
  final String orderID;
  final String date;
  final String shippedDate;
  final String dateReceived;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Merchandise Subtotal",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black54),
            ),
            Text(
              "₱$merchandiseSubtotal",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping Subtotal",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black54),
            ),
            Text(
              "₱$shippingFee",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Total",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black54),
            ),
            Text(
              "₱$orderTotal",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
        Divider(
          height: 20,
          thickness: .25,
          color: Colors.black38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order ID",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black54),
            ),
            Text(
              "$orderID",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Time",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black38),
            ),
            Text(
              "$date",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black38),
            ),
          ],
        ),
        shippedDate == ""
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipped Time",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black38),
                      ),
                      Text(
                        "$shippedDate",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
        dateReceived == ""
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Time",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black38),
                      ),
                      Text(
                        "$dateReceived",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}
