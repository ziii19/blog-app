import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlocUpload>(_onBlogUpload);
  }

  void _onBlogUpload(BlocUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await uploadBlog(UploadBlogParam(
      blogId: event.blogId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    result.fold(
      (l) => emit(BlogFailure(l.toString())),
      (r) => emit(
        BlogSuccess(),
      ),
    );
  }
}
