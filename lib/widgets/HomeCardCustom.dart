import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeCardCustom extends StatelessWidget {
  String? image;
  String? title;
  Widget? navigatorpage;
  Function()? ontap;
  HomeCardCustom({
    this.image,
    this.navigatorpage,
    this.title,
    required this.width,
    this.ontap,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black,
                          blurStyle: BlurStyle.normal)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    image!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            AutoSizeText(
              title!,
              minFontSize: 14,
              maxFontSize: 16,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Color(0xff3abcb0)),
            ),
          ],
        ),
      ),
    );
  }
}
