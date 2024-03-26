import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';
import 'package:movieapp/core/widgets/release_widget/release_item.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../models/PopularMovie.dart';


class ReleaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Releases',
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
            child: FutureBuilder<PopularMovie>(
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
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ReleaseItem(result: popularList[index]);
                  },
                  itemCount: popularList.length,
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
