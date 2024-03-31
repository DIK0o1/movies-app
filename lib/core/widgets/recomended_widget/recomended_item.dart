import 'package:flutter/material.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../constants/app_colors.dart';
import '../../../models/TopRatedMovie.dart';
import '../../screens/movie_details/movie_details.dart';


class RecomendedItem extends StatefulWidget {
  Results result;

  RecomendedItem({required this.result});

  @override
  State<RecomendedItem> createState() => _RecomendedItemState();
}

class _RecomendedItemState extends State<RecomendedItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushNamed(MovieDetails.routeName,
            arguments: await ApiManager.getMovieDetails(widget.result.id ?? 0));
      },
      child: Container(
        padding: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:AppColors.backgroundColor
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(

                    child: Image.network(
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.result.posterPath}',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * .3,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  Image.asset('assets/images/bookmark.png'),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: AppColors.yellowColor),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.result.voteAverage}',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '${widget.result.title}',
              style: TextStyle(
                color: AppColors.whiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '${widget.result.releaseDate}',
              style: const TextStyle(
                color:AppColors.lightGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
