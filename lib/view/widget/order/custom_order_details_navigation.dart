import 'package:flutter/material.dart';

class CustomOrderDetailsNavigation extends StatelessWidget {
  const CustomOrderDetailsNavigation({super.key, required this.amountPayable});
  final String amountPayable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(1, 0),
            blurRadius: 5,
            spreadRadius: 1.2,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "Amount Payable: ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 15, color: Colors.black54),
                ),
              ),
              Text(
                "₱$amountPayable",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 1, 42),
              shape: const RoundedRectangleBorder(),
              backgroundColor: Color.fromARGB(47, 34, 34, 34),
            ),
            onPressed: () {},
            child: Text("Pending",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black26)),
          ),
        ],
      ),
    );
  }
}
