import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParam> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParam params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      blogId: params.blogId,
      topics: params.topics,
    );
  }
}

class UploadBlogParam {
  final String blogId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParam(
      {required this.blogId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
