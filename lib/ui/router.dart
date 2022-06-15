import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectrio/constants/route_name.dart';
import 'package:projectrio/ui/views/camera_view.dart';
import 'package:projectrio/ui/views/dashboard_view.dart';
import 'package:projectrio/ui/views/login_view.dart';
import 'package:projectrio/ui/views/sign_up_view.dart';
import 'package:projectrio/ui/views/report_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name){
    case LoginViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: LoginView()
      );
    case SignUpViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: SignUpView()
      );
    case CameraViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: CameraView()
      );
    case DashboardViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: DashboardView()
      );
    case ReportViewRoute:
      return _pageRoute(
          routeName: settings.name,
          viewToShow: ReportView()
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                  'No route defined for ${settings.name}'
              ),
            ),
          )
      );
  }
}

PageRoute _pageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow,
      settings: RouteSettings(
          name: routeName
      )
  );
}