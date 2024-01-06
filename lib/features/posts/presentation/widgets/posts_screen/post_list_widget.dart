import 'package:clean_architecture_posts/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context , index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              posts[index].body,
              style: TextStyle(
                fontSize: 16
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => PostDetailScreen(post: posts[index]))) ;
            },
          );
        },
        separatorBuilder: (context , index) {
          return const Divider(thickness: 1);
        },
        itemCount: posts.length
    );
  }
}
