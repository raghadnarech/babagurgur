import 'package:baba_karkar/widgets/SkelatonCard.dart';
import 'package:baba_karkar/widgets/SkelatonCardList.dart';
import 'package:flutter/material.dart';

class ListSkelatonList extends StatelessWidget {
  const ListSkelatonList({
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
      itemBuilder: (context, index) =>
          SkelatonCardList(width: width, height: height),
      itemCount: 10,
    );
  }
}
