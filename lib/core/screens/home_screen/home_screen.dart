import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/widgets/release_widget/release_widget.dart';

import '../../widgets/popular_widget/popular_widget.dart';
import '../../widgets/recomended_widget/recomended_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Expanded(
          flex: 5,
          child: PopularWidget(),
        ),

        Expanded(
          flex: 3,
          child: ReleaseWidget(),
        ),
        const SizedBox(height: 5,),
        Expanded(
          flex: 4,
          child: RecomendedWidget(),
        ),
      ],
    );
  }
}
