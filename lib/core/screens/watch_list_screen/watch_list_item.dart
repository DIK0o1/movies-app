import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';
import 'package:movieapp/models/WatchListModel.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../firebase_utils/firebase_utils.dart';
import '../../../models/GenreMovieDetails.dart';
import '../movie_details/movie_details.dart';


class WatchListItem extends StatelessWidget {
  int id;

  String image;

  String title;

  String date;

  String content;
  WatchListModel result;

  WatchListItem({
    required this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.content,
    required this.result
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushNamed(MovieDetails.routeName,
            arguments: await ApiManager.getMovieDetails(result.id));
      },
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height *.2,
              child: Stack(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2$image',
                    fit: BoxFit.cover,
                    width: 150,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseUtils.deleteWatchListFromFirebase(id);
                    },
                    child: Image.asset('assets/images/bookmarkDone.png'),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  content,
                  style: TextStyle(color: AppColors.whiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
