import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/LoginButtonWidget.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/LoginErrorWidget.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/LogoContWidget.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/TextFormFieldPassWidget.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/TextFormFieldWidget.dart';
import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/startingContWidget.dart';
import 'package:mediverse/Features/PatientDashboard/MainScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../Constants/Themes.dart';
import '../../../../../GlobalWidgets/titleText.dart';
import '../../../RegisterChoice/RegisterChoiceScreen.dart';
import '../Manager/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'LoginPage';
  String? email;

  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreenWidget(),
              ));
          isLoading = false;
        } else if(state is LoginFailure){
          showSnackbar(context, 'Something went wrong, Try again');
          isLoading = false;
          print(' Login Failure');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Form(
              key: formKey,
              child: Stack(
                children: [
                  const startingContWidget(),
                  SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const LogoContWidget(),
                          const titleText(
                            text: "Login",
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 0, 0),
                              child: Text(
                                  'Welcome Back', style: Themes.bigHeadline),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(15, 40, 0, 20),
                              child: Text('Please Enter Your Email and Password',
                                  style: Themes.titleButton),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12, 0, 12, 15),
                            child: TextFormFieldWidget(
                              text: "Email",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                } else if (!value.contains('@')) {
                                  return 'Formatted Email is required';
                                }
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
                            child: TextFormFieldPassWidget(
                              text: "Password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is required';
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ),
                          LoginButtonWidget(
                            text: "Login",
                            screen: null,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context)
                                    .loginUser(
                                    email: email!, password: password!);
                                print('BA3DDDDD el Cubitttttttttttt');
                                // Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => MainScreenWidget(),
                                //         ));
                              } else {}
                            },
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 6, 0, 12),
                              child: Center(
                                child: Text('Forget Password?',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 12),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {},
                              child: RichText(
                                textScaleFactor: MediaQuery
                                    .of(context)
                                    .textScaleFactor,
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
                                              builder: (context) =>
                                              const RegisterChoice(),
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
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/LoginButtonWidget.dart';
// import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/LogoContWidget.dart';
// import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/TextFormFieldPassWidget.dart';
// import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/TextFormFieldWidget.dart';
// import 'package:mediverse/Features/Beginning/LoginScreen/presentation/views/widgets/startingContWidget.dart';
// import 'package:mediverse/Features/PatientDashboard/MainScreen.dart';
// import 'package:mediverse/Features/PatientDashboard/MedicalRecord/LabResultsScreen/presentation/Views/LabResultsScreen.dart';
//
// import '../../../../../Constants/Themes.dart';
// import '../../../../../GlobalWidgets/titleText.dart';
// import '../../../RegisterChoice/RegisterChoiceScreen.dart';
// import '../Manager/login_cubit/login_cubit.dart';
//
// class LoginScreen extends StatelessWidget {
//
//   GlobalKey<FormState> formKey = GlobalKey();
//
//   static String id = 'LoginPage';
//   String? email;
//
//   String? password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Stack(
//           children: [
//             const startingContWidget(),
//             SingleChildScrollView(
//                 child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 const LogoContWidget(),
//                 const titleText(
//                   text: "Login",
//                 ),
//                 Align(
//                   alignment: const AlignmentDirectional(0, 0),
//                   child: Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                     child: Text('Welcome Back', style: Themes.bigHeadline),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Align(
//                   alignment: const AlignmentDirectional(-1, -1),
//                   child: Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(15, 40, 0, 20),
//                     child: Text('Please Enter Your Email and Password',
//                         style: Themes.titleButton),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 15),
//                   child: TextFormFieldWidget(
//                     text: "Email",
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Field is required';
//                       } else if (!value.contains('@')) {
//                         return 'Formatted Email is required';
//                       }
//                     },
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
//                   child: TextFormFieldPassWidget(
//                     text: "Password",
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Field is required';
//                       }
//                     },
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   ),
//                 ),
//                 LoginButtonWidget(
//                   text: "Login",
//                   screen: null,
//                   onPressed: () async{
//                     if (formKey.currentState!.validate()) {
//                       BlocProvider.of<LoginCubit>(context)
//                           .loginUser(email: email!, password: password!);
//                       print('BA3D BLOCCCCCCCCC');
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreenWidget(),));
//                       print('Ba3d pushhhhhhhhhhhh');
//                     } else {
//
//                     }
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
//                   child: InkWell(
//                     splashColor: Colors.transparent,
//                     focusColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     onTap: () async {},
//                     child: RichText(
//                       textScaleFactor: MediaQuery.of(context).textScaleFactor,
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: 'Don\'t have an account? ',
//                             style: Themes.verySmallText,
//                           ),
//                           TextSpan(
//                             text: ' Sign Up here',
//                             style: Themes.labelColored,
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => const RegisterChoice(),
//                                   ),
//                                 );
//                               },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
