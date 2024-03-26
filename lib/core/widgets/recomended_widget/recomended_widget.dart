import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/recomended_widget/recomended_item.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../constants/app_colors.dart';
import '../../../models/TopRatedMovie.dart';

class RecomendedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended',
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
            child: FutureBuilder<TopRatedMovie>(
              future: ApiManager.getTopRatedMovie(),
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
                var topRatedList = snapshot.data?.results ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return RecomendedItem(result: topRatedList[index]);
                  },
                  itemCount: topRatedList.length,
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
