import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/blog_models.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogModel>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String blogId,
    required List<String> topics,
  });
}
