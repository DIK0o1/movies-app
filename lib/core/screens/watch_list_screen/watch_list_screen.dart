import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';
import 'package:movieapp/core/screens/watch_list_screen/watch_list_item.dart';

import '../../../firebase_utils/firebase_utils.dart';
import '../../../models/WatchListModel.dart';

class WatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WatchList ',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<WatchListModel>>(
        stream: FirebaseUtils.getWatchListFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('${snapshot.error.toString()}');
            return SizedBox();
          }
          print('${snapshot.data?.docs.length}');
          var watchList =
              snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

          return ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(color: AppColors.greyColor, thickness: 1),
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return WatchListItem(
                id: watchList[index].id,
                title: watchList[index].title,
                content: watchList[index].content,
                date: watchList[index].date,
                image: watchList[index].image,
                result: watchList[index],
              );
            },
            itemCount: watchList.length,
          );
        },
      ),
    );
  }
}
