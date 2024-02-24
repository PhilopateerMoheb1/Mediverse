import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/CustomSignUpLogin.dart';
import '../../../Widgets/CustomSignUpWith.dart';
import '../../../Widgets/CustomTextFormField.dart';
import '../../../Widgets/CustomTextFormField2.dart';
import '../../../Widgets/CustomTextFormField3.dart';
import '../../../Widgets/LogoContainer.dart';
import '../../../Widgets/StartingCont.dart';
import '../../../Widgets/googleButton.dart';
import '../../../Widgets/titleText.dart';

class DoctorSignUpScreen extends StatelessWidget {
  const DoctorSignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          startingCont(),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 88,),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 70,),
                          LogoCont(),
                          titleText(text: "Doctor Sign Up"),
                          SizedBox(height: 40,),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField(text: "Name",),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField2(text: "Age",icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField(text: "National ID",),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField2(text: "Specialty",icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField(text: "Hospital Or Clinic Name",),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField(text: "License Number",),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: CustomTextFormField(text: "Email",),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                  child: CustomTextFormField3(text: "Password",),
                ),
                CustomSignUpLogin(text: "Sign Up", screen: null,),
                CustomSignUpWith(),
                googleButton(),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}