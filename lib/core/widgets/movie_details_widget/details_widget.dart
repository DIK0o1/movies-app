import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../constants/app_colors.dart';
import '../../../models/SimilarMovie.dart';
import '../../../models/TopRatedMovie.dart';
import '../../screens/movie_details/movie_details.dart';

class DetailsWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Like This',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<SimilarMovie>(
              future: ApiManager.getSimilarMovie(args.id ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
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
                              ApiManager.getPopularMovie();
                            },
                            child: const Text('Try Again'))
                      ],
                    ),
                  );
                }
                var similarList = snapshot.data?.results ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.of(context).pushNamed(
                            MovieDetails.routeName,
                            arguments: await ApiManager.getMovieDetails(
                                similarList[index].id ?? 0));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff343534),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2${similarList[index].posterPath}',
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        .3,
                                  ),
                                  Image.asset(
                                      'assets/images/bookmark.png'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: AppColors.yellowColor,),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${similarList[index].voteAverage}',
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
                              '${similarList[index].title}',
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
                              '${similarList[index].releaseDate}',
                              style: const TextStyle(
                                color: Color(0xffB5B4B4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: similarList.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 8,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
