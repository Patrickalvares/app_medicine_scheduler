import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/select_day_bloc.dart';
import 'package:app_medicine_scheduler/pages/home_page.dart';
import 'package:app_medicine_scheduler/tools/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationManager.initialize();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiBlocProvider(providers: [
      BlocProvider<MedicineBloc>(
        create: (context) => MedicineBloc(),
      ),
      BlocProvider<SelectDayBloc>(create: (context) => SelectDayBloc())
    ], child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final appGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 239, 248, 247),
      Color.fromARGB(255, 122, 255, 242),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4DB6AC),
        accentColor: const Color(0xFF81C784),
        backgroundColor: const Color(0xFFE0F2F1),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.black),
          headline2: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4DB6AC),
          titleTextStyle:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.transparent, // Adicione esta linha
      ),
      home: GradientBackground(gradient: appGradient, child: const HomePage()),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;

  const GradientBackground(
      {Key? key, required this.child, required this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: child,
    );
  }
}
