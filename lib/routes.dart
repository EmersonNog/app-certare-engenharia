import 'package:certare_app/pages/pdf_page.dart';
import 'package:flutter/cupertino.dart';
import 'pages/home.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> routes = <String, WidgetBuilder>{
    '/home': (context) => const Home(),
    '/pdf': (context) => const PdfPage(),
  };

  static String initialRoute = '/home';
}