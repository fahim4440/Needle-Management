import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:needle_management/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:needle_management/screen/homepage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Needle Management',
      theme: ThemeData(
        fontFamily: 'Montserrat'
      ),
      home: BlocProvider(
        create: (context) => HomepageBloc(),
        child: const Homepage(),
      ),
    );
  }
}

