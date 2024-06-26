import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mediverse/Core/utils/Globals.dart';
import 'package:mediverse/Core/utils/Globals.dart';
import 'package:mediverse/Core/utils/api_keys.dart';
import 'package:mediverse/Core/utils/serviceLocator.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/AppointmentDetailsScreen/presentation/Views/AppointmentDetailsScreen.dart';
import 'package:mediverse/Features/PatientDashboard/MainScreen.dart';

void main() async {
  setupIDServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applfication.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreenWidget(),
    );
  }
}
