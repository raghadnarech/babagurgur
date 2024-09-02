import 'package:auto_size_text/auto_size_text.dart';
import 'package:baba_karkar/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CardSelectImage extends StatelessWidget {
  Widget? image;
  String? title;
  bool? isfill;
  Widget? navigatorpage;
  Function()? ontap;
  Function()? ondelete;
  CardSelectImage({
    this.ondelete,
    this.isfill,
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
              child: Stack(
                children: [
                  Container(
                    width: width * 0.5,
                    height: 150,
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
                        padding: const EdgeInsets.all(8.0), child: image),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Visibility(
                        visible: isfill!,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      languageprovider.locale == Locale('ar')
                                          ? Radius.circular(25)
                                          : Radius.circular(0),
                                  bottomLeft:
                                      languageprovider.locale == Locale('ar')
                                          ? Radius.circular(25)
                                          : Radius.circular(0),
                                  bottomRight:
                                      languageprovider.locale == Locale('ar')
                                          ? Radius.circular(0)
                                          : Radius.circular(25),
                                  topLeft:
                                      languageprovider.locale == Locale('ar')
                                          ? Radius.circular(0)
                                          : Radius.circular(25))),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: ondelete,
                          ),
                        )),
                  ),
                ],
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
