import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'controllers/host_controller.dart';
import 'controllers/key_controller.dart';
import 'controllers/menu_controller.dart';
import 'controllers/token_list_controller.dart';
import 'screens/main/main_screen.dart';
import 'shared/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env",); //
  String envProjectId = dotenv.get('PROJECT_ID');
  print("envProjectId :: " + envProjectId);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProxyProvider<AuthController, MenuController>(
      update: (context, auth, previousMenu) => MenuController(auth),
      create: (BuildContext context) => MenuController(null),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => TokenListController()..getTokens(),
    // ),
    // ChangeNotifierProvider(
    //   create: (context) => HostController()..getHosts(),
    // ),
    ChangeNotifierProvider(
      create: (context) => KeyController()..getKmsKeys(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
      // home: const MainScreen(),
    );
  }
}
