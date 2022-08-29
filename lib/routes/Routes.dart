import 'package:uni_campus/routes/RootRoute.dart';
import 'package:uni_campus/routes/YellowPages.dart';
import 'package:uni_campus/routes/square/createRoute.dart';
import 'package:uni_campus/routes/square/foodRoute.dart';
import 'package:uni_campus/routes/square/helpRoute.dart';
import 'package:uni_campus/routes/square/myRoute.dart';
import 'package:uni_campus/routes/square/serviceRoute.dart';
import 'package:uni_campus/routes/square/studyRoute.dart';

class Routes {
  static String root = "/";
  static String setting = "/setting";
  static String sign = "/sign";
  static String universitySelect = "/setting/universities";

  static String login = "/login/initialization";
  static String register = "/login/register";
  static String initialization = "/login";

  static String squareCreate = "/square/create";
  static String squareFood = "/square/food";
  static String squareHelp = "/square/help";
  static String squareMy = "/square/my";
  static String squareService = "/square/service";
  static String squareStudy = "/square/study";
  // static String myPage = "/MyPage";

  static String universityWeb = "/universityWeb";
  // static String library = "/library";
  static String yellowPages = "/yellowPages";

  static final routers = {
    root: (content) => RootRoute(),

    squareCreate: (content) => CreateRoute(),
    squareFood: (content) => FoodRoute(),
    squareHelp: (content) => HelpRoute(),
    squareMy: (content) => MyRoute(),
    squareService: (content) => ServiceRoute(),
    squareStudy: (content) => StudyRoute(),

    yellowPages: (content) => TelephonePage(),

    // universityWeb: (content) => UniversityWebRoute(),

    // library:(content) => LibraryQuiry(),
  };
}
