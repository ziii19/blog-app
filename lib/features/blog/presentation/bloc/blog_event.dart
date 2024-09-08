part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlocUpload extends BlogEvent {
  final String blogId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  BlocUpload({
    required this.blogId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
