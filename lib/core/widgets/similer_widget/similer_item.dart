import 'package:flutter/material.dart';
import 'package:movieapp/constants/app_colors.dart';

import '../../../config/api_manager/api_manger.dart';
import '../../../firebase_utils/firebase_utils.dart';
import '../../../models/SimilarMovie.dart';
import '../../../models/WatchListModel.dart';
import '../../screens/movie_details/movie_details.dart';


class SimilerItem extends StatefulWidget {
  Results result;

  SimilerItem({required this.result});

  @override
  State<SimilerItem> createState() => _SimilerItemState();
}

class _SimilerItemState extends State<SimilerItem> {
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
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushNamed(MovieDetails.routeName,
            arguments: await ApiManager.getMovieDetails(widget.result.id ?? 0));
      },
      child:Container(
        padding: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blackColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.result.posterPath}',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context)
                          .size
                          .width *
                          .3,
                    ),
                    borderRadius: BorderRadius.circular(5),
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
            Row(
              children: [
                Icon(Icons.star,color: AppColors.yellowColor,),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.result.voteAverage}',
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
              '${widget.result.title}',
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
              '${widget.result.releaseDate}',
              style: const TextStyle(
                color: Color(0xffB5B4B4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
