import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

import '../../../models/PopularMovie.dart';


class ReleaseItem extends StatefulWidget {
  Results result;

  ReleaseItem({required this.result});

  @override
  State<ReleaseItem> createState() => _ItemState();
}

class _ItemState extends State<ReleaseItem> {

  @override


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.result.posterPath}',
              fit: BoxFit.fitWidth,
            ),
            InkWell(
              onTap: () {

              },
              child: Image.asset('assets/images/bookmark.png'),
            ),
          ],
        ),
      ),
    );
  }
}
