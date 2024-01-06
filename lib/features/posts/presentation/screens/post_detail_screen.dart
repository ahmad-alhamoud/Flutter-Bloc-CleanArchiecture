
import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';
import '../widgets/post_detail_screen/post_detail_widget.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post ;
  const PostDetailScreen({Key? key , required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar() ,
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
   return AppBar(
      title: const Text(
          "Post Detail"
      ),
    ) ;
  }

  Widget  _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post : post),
      ),
    ) ;
  }
}
