import 'package:flutter/material.dart';

class DialogMessage extends StatelessWidget {
  const DialogMessage({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black54, fontSize: 14),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
            ),
            SizedBox(
              height: size.height * .055,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text("Okay",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 15,
                            color: Colors.teal,
                            fontWeight: FontWeight.w400)),
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
