import 'package:ecommerce/bindings/initial_bindings.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
              headline1: GoogleFonts.manrope(
                  fontSize: 18, fontWeight: FontWeight.w600),
              headline2: GoogleFonts.manrope(
                  fontSize: 22, fontWeight: FontWeight.w600),
              headline3: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
              headline5: GoogleFonts.manrope(
                fontSize: 16,
              ),
              headline6: GoogleFonts.manrope(
                fontSize: 14,
              ),
              bodyText1: GoogleFonts.manrope(
                fontSize: 16,
              ),
              bodyText2: GoogleFonts.manrope(
                  fontSize: 16, fontWeight: FontWeight.w300)),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            foregroundColor: Colors.black,
            titleTextStyle: TextTheme(
              headline6: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(183, 0, 0, 0)),
            ).headline6,
          )),
      getPages: routes,
      builder: EasyLoading.init(),
    );
  }
}
