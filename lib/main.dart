import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/providers/search_provider.dart';
import 'package:meeting_check/routes/router.dart' as router;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AgendaRapatProvider>(
          create: (context) => AgendaRapatProvider(),
        ),
        ChangeNotifierProvider<SearchHistoryModel>(
          create: (context) => SearchHistoryModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);
    await agendaProvider.fetchAgendaRapat();
    await agendaProvider.fetchAgendaRapatSelesai();
    initializeDateFormatting();
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DaftarHadir',
      theme: ThemeData(
        // scaffoldBackgroundColor: primaryColor,
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color(0xffEFF2F5),
        // ),
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          titleLarge: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          titleMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          titleSmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: secondaryColor,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xff000000),
          ),
        ),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          // elevation: 2,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: primaryColor,
            surfaceTintColor: Colors.white),
        useMaterial3: true,
        dialogBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      onGenerateRoute: router.RouteGenerator.generateRoute,
      // home: const MyHomePage(title: 'MeetingCheck'),
    );
  }
}
