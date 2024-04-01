import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

import '../../../firebase_utils/firebase_utils.dart';
import '../../../models/GenreMovieDetails.dart';
import '../../../models/WatchListModel.dart';

class BrowseItem extends StatefulWidget {
  String image;

  String title;

  String date;

  String content;
  Results result;



  BrowseItem({
    required this.image,
    required this.title,
    required this.date,
    required this.content,
    required this.result
  });

  @override
  State<BrowseItem> createState() => _BrowseItemState();
}

class _BrowseItemState extends State<BrowseItem> {
  late WatchListModel model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var isExist = await FirebaseUtils.isInWatchList(widget.result.id!);
      model.check = isExist;
      setState(() {});
    });

    model = WatchListModel(
      id: widget.result.id ?? 0,
      image: widget.result.posterPath ?? '',
      title: widget.result.title ?? '',
      content: widget.result.overview ?? '',
      date: widget.result.releaseDate ?? '',
      check: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: Container(
            padding: const EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height *.20,

            child: Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.image}',
                  fit: BoxFit.cover,
                  width: 150,
                ),
                InkWell(
                  onTap: () {
                    if (model.check) {
                      FirebaseUtils.deleteWatchListFromFirebase(model.id);
                    } else {
                      FirebaseUtils.addWatchListToFirebase(model);
                    }
                    model.check = !model.check;
                    setState(() {});
                  },
                  child: model.check == true
                      ? Image.asset('assets/images/bookmarkDone.png')
                      : Image.asset('assets/images/bookmark.png'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(color: AppColors.whiteColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.date,
                style: TextStyle(color: AppColors.whiteColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.content,
                style: TextStyle(color: AppColors.whiteColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
