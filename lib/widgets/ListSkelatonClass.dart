import 'package:baba_karkar/widgets/SkelatonCard.dart';
import 'package:flutter/material.dart';

class ListSkelatonClass extends StatelessWidget {
  const ListSkelatonClass({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          SkelatonCard(width: width, height: height),
      itemCount: 5,
    );
  }
}
