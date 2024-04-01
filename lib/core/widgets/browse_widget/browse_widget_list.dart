import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../models/GenreMovieDetails.dart';
import '../../../models/GenresMovieModel.dart';
import '../../screens/movie_details/movie_details.dart';
import 'browse_item.dart';


class BrowseListWidget extends StatelessWidget {
  static const String routeName = 'browse_widget';

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Genres;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${args.name} List',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder<GenreMovieDetails>(
        future: ApiManager.genresMovieDetails(args.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.error.toString()),
                  ElevatedButton(
                      onPressed: () {
                        ApiManager.genresMovieDetails(args.id ?? 0);
                      },
                      child: const Text('Try Again'))
                ],
              ),
            );
          }
          var genreListDetails = snapshot.data?.results ?? [];
          return ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  Navigator.of(context).pushNamed(
                    MovieDetails.routeName,
                    arguments: await ApiManager.getMovieDetails(
                        genreListDetails[index].id ?? 0),
                  );
                },
                child: BrowseItem(
                  image: genreListDetails[index].backdropPath ?? '',
                  title: genreListDetails[index].title ?? '',
                  date: genreListDetails[index].releaseDate ?? '',
                  content: genreListDetails[index].overview ?? '',
                  result: genreListDetails[index],
                ),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(color: AppColors.greyColor, thickness: 1),
            itemCount: genreListDetails.length,
          );
        },
      ),
    );
  }
}
