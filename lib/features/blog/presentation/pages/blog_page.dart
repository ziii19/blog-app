import 'package:blog_app/core/utils/get_greeting.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/show_snackbar.dart';
import 'add_new_blog_page.dart';
import '../widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
              context, LoginPage.route(), (route) => false);
        } else if (state is AuthFailure) {
          showSnackBar(context: context, content: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${getGreeting()} 👋'),
                Text(
                  state is AuthSuccess ? state.user.name : 'blog app',
                  style: const TextStyle(
                      fontSize: 16, color: AppPallete.greyColor),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, AddNewBlogPage.route());
                  },
                  icon: const Icon(CupertinoIcons.add_circled)),
            ],
          ),
          body: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogFailure) {
                showSnackBar(context: context, content: state.error);
              }
            },
            builder: (context, state) {
              if (state is BlogLoading) {
                return const Loader();
              }
              if (state is BlogDiplaySuccess) {
                return ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) {
                      final blog = state.blogs[index];
                      return BlogCard(
                        blog: blog,
                        color: index % 3 == 0
                            ? AppPallete.gradient1
                            : index % 3 == 1
                                ? AppPallete.gradient2
                                : AppPallete.gradient3,
                      );
                    });
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            child: const Icon(Icons.logout_rounded),
          ),
        );
      },
    );
  }
}
