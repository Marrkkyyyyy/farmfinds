import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPopupMenuItem {
  final int value;
  final IconData icon;
  final String text;

  CustomPopupMenuItem({
    required this.value,
    required this.icon,
    required this.text,
  });
}

class CustomPopupButton extends StatelessWidget {
  final List<CustomPopupMenuItem> items;
  final Function(int) onItemSelected;
  const CustomPopupButton({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        padding: EdgeInsets.zero,
        icon: FaIcon(
          FontAwesomeIcons.ellipsisVertical,
          color: Colors.white,
          size: 20,
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Edit Profile",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black))
                  ],
                )),
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Colors.teal, size: 20),
                    SizedBox(
                      width: 8,
                    ),
                    Text("My Addresses",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black))
                  ],
                )),
          ];
        },
        onSelected: (value) async {
          onItemSelected(value);
        });
  }
}
