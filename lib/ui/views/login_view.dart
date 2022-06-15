import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:projectrio/constants/const.dart';
import 'package:projectrio/ui/shared/shared_style.dart';
import 'package:projectrio/ui/shared/ui_helper.dart';
import 'package:projectrio/ui/widgets/button_widget.dart';
import 'package:projectrio/ui/widgets/text_field_widget.dart';
import 'package:projectrio/viewmodels/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
          body: LoadingOverlay(
            isLoading: model.busy,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        verticalSpaceMedium,
                        Text("Login Page", style: titleTextStyle,),
                        verticalSpaceSmall,
                        Text("SMKN 2 Bandung", style: titleTextStyle,),
                        verticalSpaceSmall,
                        Image.asset(
                          'assets/Logo.jpg',
                          width: size.width*0.3,
                          height: size.width*0.3,
                        ),
                        verticalSpaceMedium,
                        TextFieldWidget(
                            hintText: 'E-Mail',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                            textFieldController: model.emailController,
                            colorIcon: color_main
                        ),
                        verticalSpaceSmall,
                        TextFieldWidget(
                            hintText: 'Password',
                            icon: Icons.lock,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: true,
                            textFieldController: model.passwordController,
                            colorIcon: color_main
                        ),
                        verticalSpaceMedium,
                        ButtonWidget(
                            title: 'Login',
                            onPressedFunction: (){
                              model.logginAccount(context);
                            },
                            bgColor: color_main
                        ),
                        verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account? '),
                            InkWell(
                              onTap: (){
                                model.navigateToSignUpView();
                              },
                              child: Text('Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: color_main,
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceLarge
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
