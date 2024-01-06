
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddPostUseCase {
  final PostsRepository repository ;

  AddPostUseCase(this.repository) ;

  Future<Either<Failure,Unit>> call(Post post) async {
    return await repository.addPost(post) ;
  }
}