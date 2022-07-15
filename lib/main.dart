import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:moodometer/logic/cubit/internet_cubit.dart';
import 'package:moodometer/logic/homebloc/home_bloc.dart';
import 'package:moodometer/presentation/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({Key? key, required this.connectivity}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final InternetCubit internetCubit =
        InternetCubit(connectivity: connectivity);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: internetCubit),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mood-O-Meter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
