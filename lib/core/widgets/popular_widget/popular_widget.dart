import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';
import 'package:movieapp/core/widgets/popular_widget/popular_item.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../models/PopularMovie.dart';
import '../../screens/movie_details/movie_details.dart';


class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMovie>(
      future: ApiManager.getPopularMovie(),
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
                      ApiManager.getPopularMovie();
                    },
                    child: const Text('Try Again'))
              ],
            ),
          );
        }
        var popularList = snapshot.data?.results ?? [];
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 1,
          ),
          itemCount: popularList.length,
          itemBuilder: (context, index, realIndex) => InkWell(
            onTap: ()  async {
              Navigator.of(context).pushNamed(
                  MovieDetails.routeName,
                  arguments: await ApiManager.getMovieDetails(
              popularList[index].id ?? 0),
              );
            },
            child: PopularItem(results: popularList[index]),
          ),
        );
      },
    );
  }
}
