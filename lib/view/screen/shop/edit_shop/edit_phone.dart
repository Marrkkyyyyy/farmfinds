import 'package:ecommerce/view/widget/auth/custom_text_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EditPhone extends StatelessWidget {
  EditPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.teal,
                    size: 20,
                  ),
                )),
            leadingWidth: 34,
            title: const Text("Change Phone Number"),
          ),
          body: Form(
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  CustomTextFormAuth(
                      keyboardType: TextInputType.phone,
                      hintText: "New Phone Number",
                      controller: TextEditingController(),
                      valid: (val) {
                        return null;

                        // return validInput(val, "phoneNumber");
                      },
                      icon: Icons.call),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 1, 40),
                        backgroundColor:
                            const Color.fromARGB(255, 31, 129, 121),
                        shape: const RoundedRectangleBorder()),
                    child: Text(
                      "Update",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
