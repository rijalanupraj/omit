import 'package:flutter/material.dart';

class DismissSwipeBackground extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final bool isLeft;

  const DismissSwipeBackground(
      {@required this.backgroundColor,
      @required this.icon,
      @required this.iconColor,
      @required this.isLeft});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Align(
        child: Row(
          mainAxisAlignment:
              isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      ),
    );
  }
}
