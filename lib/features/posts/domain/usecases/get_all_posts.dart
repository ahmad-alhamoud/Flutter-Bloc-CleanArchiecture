
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUseCase {
  final PostsRepository repository ;

  GetAllPostsUseCase(this.repository) ;

  Future<Either<Failure,List<Post>>> call() async {
   return await repository.getAllPosts() ;
  }
}