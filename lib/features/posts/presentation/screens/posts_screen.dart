
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/screens/post_add_update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_screen/message_display_widget.dart';
import '../widgets/posts_screen/post_list_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar() ,
        body: _buildBody() ,
    floatingActionButton: _buildFloatingActionButton(context),
    ) ;

  }

  AppBar _buildAppbar() =>
      AppBar(
        title: const Text("Posts"),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          }
          else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context) ,
              child: PostListWidget(
                  posts: state.posts
              ),
            );
          }
          else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
                message: state.message
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

 Future<void>  _onRefresh(BuildContext context)  async  {
     BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent()) ;
  }

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (_) => PostAddUpdateScreen(isUpdatePost: false))) ;
      },
      child: const Icon(Icons.add),
    ) ;
  }
}
