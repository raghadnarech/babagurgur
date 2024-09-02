import 'package:baba_karkar/widgets/SkelatonCard.dart';
import 'package:baba_karkar/widgets/SkelatonCardGrid.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:flutter/material.dart';

class GridSkelaton extends StatelessWidget {
  const GridSkelaton({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          SkelatonCardGrid(width: width, height: height),
      itemCount: 10,
    );
  }
}
