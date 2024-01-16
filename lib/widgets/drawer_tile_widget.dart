import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';

class DrawerListTile extends StatelessWidget {
  final IconData tileIcon;
  final String tileName;
  final double? iconSize;
  final double? textSize;
  final Function() tileOnTap;
  const DrawerListTile({
    required this.tileIcon,
    required this.tileName,
    required this.tileOnTap,
    required this.iconSize,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            tileIcon,
            size: iconSize,
            color: Colors.black,
          ),
          SizedBox(
            width: width(context) * 0.06,
          ),
          CustomTextWidget(
            text: tileName,
            fontSize: textSize,
            color: Colors.black,
          )
        ],
      ),
      onTap: tileOnTap,
      contentPadding: const EdgeInsets.only(left: 10),
      // hoverColor: Colors.transparent,
      // splashColor: Colors.green.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
