import 'package:clean_architecture_posts/core/error/exceptions.dart';
import 'package:clean_architecture_posts/core/error/failures.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';


typedef Future<Unit> DeleteOrUpdateOrAppPost() ;

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo ;

  PostsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource , required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
       final remotePosts = await remoteDataSource.getAllPosts();
       localDataSource.cachePosts(remotePosts) ;
       return Right(remotePosts) ;
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
       final localPosts = await localDataSource.getCachedPosts();
       return Right(localPosts) ;
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }

  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post)  async {
    final PostModel postModel = PostModel(title: post.title, body: post.body) ;
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel) ;
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
   return _getMessage(() {
     return remoteDataSource.deletePost(postId) ;
   }) ;
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body) ;
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel) ;
    });
  }


  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAppPost deleteOrUpdateOrAddPost) async {

    if (await networkInfo.isConnected) {
      try{
       await deleteOrUpdateOrAddPost ;
        return Right(unit) ;
      } on ServerException {
        return Left(ServerFailure()) ;
      }
    }
    else {
      return left(OfflineFailure()) ;
    }
  }
}
