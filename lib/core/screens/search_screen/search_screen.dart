import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';
import 'package:movieapp/core/screens/search_screen/search_item.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../models/SearchMovieModel.dart';
import '../movie_details/movie_details.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  List<Results> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            onChanged: (text) {
              if (text.isNotEmpty) {
                query = text;
                ApiManager.searchMovie(query).then((value) {
                  results = value.results ?? [];
                  setState(() {});
                });
              } else {
                results = [];
                setState(() {});
              }
            },
            onFieldSubmitted: (text) {
              if (text.isNotEmpty) {
                query = text;
                ApiManager.searchMovie(query).then((value) {
                  results = value.results ?? [];
                  setState(() {});
                });
              } else {
                results = [];
                setState(() {});
              }
            },
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
            cursorColor: AppColors.whiteColor,
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(
                  color: AppColors.whiteColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color:  AppColors.lightGreyColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: AppColors.lightGreyColor)),
                enabled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.whiteColor,
                ),
                fillColor: const Color(0xff514F4F),
                filled: true),
          ),
          if (results.isEmpty)
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Icon(Icons.local_movies,
                  size: 100,
                  color: AppColors.lightGreyColor,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'No movies found',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          if (results.isNotEmpty)
            Expanded(
              child: FutureBuilder<SearchMovieModel>(
                future: ApiManager.searchMovie(query),
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
                                ApiManager.searchMovie(query);
                              },
                              child: const Text('Try Again'))
                        ],
                      ),
                    );
                  }
                  var searchList = snapshot.data?.results ?? [];
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                            MovieDetails.routeName,
                            arguments: await ApiManager.getMovieDetails(
                                searchList[index].id ?? 0),
                          );
                        },
                        child: SearchItem(
                          image: searchList[index].posterPath ?? '',
                          title: searchList[index].title ?? '',
                          date: searchList[index].releaseDate ?? '',
                          content: searchList[index].overview ?? '',
                          result: searchList[index],
                        ),
                      );
                    },
                    itemCount: searchList.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColors.greyColor, thickness: 1),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
