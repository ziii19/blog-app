import 'dart:io';

import '../../domain/usecases/get_all_blogs.dart';
import '../../domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _uploadBlog(UploadBlogParam(
      blogId: event.blogId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    result.fold(
      (l) => emit(BlogFailure(l.toString())),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final result = await _getAllBlogs(NoParams());
    result.fold(
      (l) => emit(
        BlogFailure(
          l.toString(),
        ),
      ),
      (r) => emit(
        BlogDiplaySuccess(r),
      ),
    );
  }
}
