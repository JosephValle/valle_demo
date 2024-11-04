import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:vumc_demo_valle/logical_interface/bloc/repos_bloc.dart";
import "package:vumc_demo_valle/network_interface/repositories/repos/repos_repository.dart";
import "package:vumc_demo_valle/user_interface/list/home_screen.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ReposRepository>(
          create: (context) => ReposRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ReposBloc>(
            create: (context) =>
                ReposBloc(reposRepository: context.read<ReposRepository>()),
          ),
        ],
        child: MaterialApp(
          title: "Flutter Demo",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
