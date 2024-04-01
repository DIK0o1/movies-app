import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/recomended_widget/recomended_item.dart';
import 'package:movieapp/core/widgets/similer_widget/similer_item.dart';
import 'package:movieapp/models/SimilarMovie.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../constants/app_colors.dart';
import '../../../models/MovieDetailModel.dart';
import '../../../models/TopRatedMovie.dart';

class SimilerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MovieDetailModel;

    return Expanded(
      child: FutureBuilder<SimilarMovie>(
        future: ApiManager.getSimilarMovie(args.id ?? 0),
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
          var similarList = snapshot.data?.results ?? [];
          return ListView.separated(
            itemBuilder: (context, index) {
              return SimilerItem(result: similarList[index]);
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
    );
  }
}
