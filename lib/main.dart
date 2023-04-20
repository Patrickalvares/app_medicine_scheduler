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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.grey),
      home: const HomePage(),
    );
  }
}
