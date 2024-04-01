import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/similer_widget/similer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../firebase_utils/firebase_utils.dart';
import '../../../models/MovieDetailModel.dart';
import '../../../models/SimilarMovie.dart';
import '../../../constants/app_colors.dart';
import '../../../models/TrailerResponse.dart';
import '../../../models/WatchListModel.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'movieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  WatchListModel? model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var args =
      ModalRoute.of(context)?.settings.arguments as MovieDetailModel;
      model = WatchListModel(
        id: args.id ?? 0,
        image: args.posterPath ?? '',
        title: args.title ?? '',
        content: args.overview ?? '',
        date: args.releaseDate ?? '',
        check: false,
      ); // Initialize model with default value
      var isExist = await FirebaseUtils.isInWatchList(model!.id);
      model!.check = isExist;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MovieDetailModel;

    if (model == null) {
      // Handle the case where model is not initialized yet
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
        body: Center(
          child: CircularProgressIndicator(), // Or any other loading indicator
        ),
      );
    }

    // Once model is initialized, continue building the UI
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
              const SizedBox(
                height: 19,
              ),
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .33,
                          height: MediaQuery.of(context).size.height * .25,
                          margin: const EdgeInsets.only(left: 22.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${args.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * .055,
                          child: InkWell(
                            onTap: () {
                              if (model!.check) {
                                FirebaseUtils.deleteWatchListFromFirebase(model!.id);
                              } else {
                                FirebaseUtils.addWatchListToFirebase(model!);
                              }
                              model!.check = !model!.check;
                              setState(() {});
                            },
                            child: model!.check == true
                                ? Image.asset('assets/images/bookmarkDone.png')
                                : Image.asset('assets/images/bookmark.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.greyColor,
                                  )),
                              child: Text(
                                '${args.genres?.elementAt(0).name}',
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.greyColor,
                                  )),
                              child: Text(
                                '${args.genres?.elementAt(1).name}',
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            '${args.overview}',
                            maxLines: 5,
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.yellowColor,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              '${args.voteAverage}',
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        child: SimilerWidget(),
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
