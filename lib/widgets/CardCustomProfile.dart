import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomCardProfile extends StatelessWidget {
  dynamic name;
  dynamic phone;
  dynamic title;
  IconData? iconData;
  CustomCardProfile({this.iconData, this.name, this.phone, this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(minFontSize: 16, maxFontSize: 18, "$name"),
                  AutoSizeText(minFontSize: 16, maxFontSize: 18, "$phone"),
                ],
              ),
              Row(
                children: [
                  Icon(
                    iconData,
                    size: 18,
                  ),
                  VerticalDivider(
                    color: Colors.transparent,
                  ),
                  AutoSizeText(minFontSize: 16, maxFontSize: 18, "$title"),
                ],
              )
            ],
          ),
        ));
  }
}
