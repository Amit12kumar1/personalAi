import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/jarvis_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set transparent dark status bar for futuristic HUD feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF050811),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'J.A.R.V.I.S.',
      debugShowCheckedModeBanner: false,
      theme: JarvisTheme.darkTheme,
      home: const MainNavigationScreen(),
    );
  }
}
