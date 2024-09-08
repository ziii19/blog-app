import 'dart:developer';

import 'core/common/cubits/cubit/app_user_cubit.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';
import 'features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = AppBlockObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => serviceLocator<AppUserCubit>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (context) => serviceLocator<BlogBloc>(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}

class AppBlockObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('$change', name: 'BLOC');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}
