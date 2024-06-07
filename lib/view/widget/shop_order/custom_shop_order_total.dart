import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/data/model/user_order_model.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';

class CustomShopOrderTotal extends StatelessWidget {
  const CustomShopOrderTotal(
      {super.key,
      required this.userOrder,
      required this.totalQuantity,
      required this.totalAmountPayable});
  final OrderItemModels userOrder;
  final int totalQuantity;
  final int totalAmountPayable;
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
                                  color: Colors.teal.shade700,
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
                          text: "Amount Payable:",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order ID",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600)),
                Text(userOrder.orderID!,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Color.fromARGB(160, 0, 0, 0),
                        fontWeight: FontWeight.w600)),
              ],
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
