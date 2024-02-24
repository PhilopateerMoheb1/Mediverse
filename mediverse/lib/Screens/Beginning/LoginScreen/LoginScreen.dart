import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mediverse/Widgets/StartingCont.dart';
import '../../../Widgets/CustomSignUpLogin.dart';
import '../../../Widgets/CustomTextFormField.dart';
import '../../../Widgets/CustomTextFormField3.dart';
import '../../../Widgets/LogoContainer.dart';
import '../../../Widgets/titleText.dart';
import '../../../conts/Themes.dart';
import '../RegisterChoice/RegisterChoiceScreen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          startingCont(),
          SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  LogoCont(),
                  titleText(text: "Login",),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Welcome Back',
                        style: Themes.bigHeadline
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 40, 0, 20),
                      child: Text(
                        'Please Enter Your Email and Password',
                        style:Themes.titleButton
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: CustomTextFormField(text: "Email",),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: CustomTextFormField3(text: "Password",),
                  ),
                  CustomSignUpLogin(text: "Login", screen: null,),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {},
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Themes.verySmallText,
                            ),
                            TextSpan(
                              text: ' Sign Up here',
                              style: Themes.labelColored,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterChoice(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}