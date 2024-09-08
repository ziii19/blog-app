import 'dart:io';

import '../../../../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog.dart';


abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String blogId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
