import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../models/MovieDetailModel.dart';
import '../../../models/SimilarMovie.dart';
import '../../../constants/app_colors.dart';
import '../../../models/TrailerResponse.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'movieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MovieDetailModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${args.title}',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<TrailerResponse>(
        future: ApiManager.youtubeMoviesResponse(args.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            );
          } else if (snapshot.hasError || snapshot.data?.success == "false") {
            return Center(
              child: IconButton(
                onPressed: () {
                  ApiManager.youtubeMoviesResponse(args.id ?? 0);
                  setState(() {});
                },
                icon: Icon(
                  Icons.restart_alt_rounded,
                  size: 100,
                  color: AppColors.whiteColor.withOpacity(.5),
                ),
              ),
            );
          }
          var results = snapshot.data?.results ?? [];
          var trailerIndex = 0;

          if (results.isNotEmpty) {
            for (int i = 0; i <= results.length - 1; i++) {
              if (results[i].type == "Trailer") {
                trailerIndex = i;
              }
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () async {
                    launchTrailer(results[trailerIndex].key ?? "");
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .25,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${args.backdropPath}',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () async {
                            launchTrailer(results[trailerIndex].key ?? "");
                          },
                          icon: Icon(
                            Icons.play_circle,
                            color: AppColors.whiteColor,
                            size: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  '${args.title}',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  '${args.releaseDate}',
                  style: const TextStyle(
                    color: AppColors.lightGreyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left section with movie poster
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                flex: 5,
                child: Container(
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
                                    // Movie item UI here
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
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> launchTrailer(String videoUrl) async {
    Uri url = Uri.parse("https://www.youtube.com/watch?v=$videoUrl");
    await launchUrl(url);
  }
}
