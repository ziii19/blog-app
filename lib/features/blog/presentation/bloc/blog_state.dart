part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}

class BlogUploadSuccess extends BlogState {}

class BlogDiplaySuccess extends BlogState {
  final List<Blog> blogs;

  BlogDiplaySuccess(this.blogs);
}
