import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediverse/AllModels/Staff.dart';
import 'package:mediverse/Constants/Themes.dart';
import 'package:mediverse/Constants/constant.dart';
import 'package:mediverse/Core/utils/Functions.dart';
import 'package:mediverse/Core/utils/Globals.dart';
import 'package:mediverse/Features/StaffDashboard/AdminMainScreen/presentation/Manager/FetechAdminInfoCubit.dart/fetech_admin_info_cubit.dart';
import 'package:mediverse/Features/StaffDashboard/HospitalStaffManagementScreenAddDoctors/presentation/Manager/FetechHospitalMangementCubit/fetech_HM_info_State.dart';
import 'package:mediverse/Features/StaffDashboard/HospitalStaffManagementScreenAddDoctors/presentation/Manager/FetechHospitalMangementCubit/fetech_HM_info_cubit.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/AppBarLabResultScreen.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/ListViewPatient.dart';

import '../../../Beginning/LoginScreen/presentation/views/LoginScreen.dart';
import '../../LabStaffProfileScreen/presentation/Views/LabStaffProfileScreen.dart';
import '../../StaffProfileScreen/presentation/Views/StaffProfileScreen.dart';

class LabStaffScreen extends StatelessWidget {
  LabStaffScreen({Key? key});

  String id = '';
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      id = args['id'];
    }

    // Use a variable to store the subscription
    Stream<DocumentSnapshot> staffStream = FirebaseFirestore.instance
        .collection('Staff')
        .doc(globalcurrentUserId)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        automaticallyImplyLeading: false,
        title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabStaffProfileScreen(),
                  ));
            },
            child: AppBarLabResultScreen()),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: StreamBuilder<DocumentSnapshot>(
          stream: staffStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              ); // Show a loading indicator while waiting for data
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              ); // Handle error state
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Text('No LabStaff available'),
              ); // Handle no data available
            }

            StaffModel staffModel = StaffModel.fromJson(snapshot.data!.data()!);
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Text(
                    'Patients List',
                    style: Themes.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: ListViewPatient(),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: kprimaryColor,
        onPressed: () async {
          final national_id = await showTextFieldDialog(
            context,
            textEditingController: textEditingController,
            title: "Add Patient's national id",
            hintText: 'National id',
          );
          textEditingController.clear();
          if (national_id != null) {
            try {
              QuerySnapshot snapshot = await FirebaseFirestore.instance
                  .collection('info_Patients')
                  .where('NationalId', isEqualTo: national_id)
                  .get();

              if (snapshot.docs.isNotEmpty) {
                id = snapshot.docs.first.id;
                DocumentReference staffDocRef = FirebaseFirestore.instance
                    .collection('Staff')
                    .doc(globalcurrentUserId);
                DocumentSnapshot staffDocSnapshot = await staffDocRef.get();
                if (staffDocSnapshot.exists &&
                    staffDocSnapshot.data() != null) {
                  // Update the array in Firestore using arrayUnion
                  // Check if the 'id' is already in the 'Jobs' array
                  Map<String, dynamic> data =
                      staffDocSnapshot.data() as Map<String, dynamic>;
                  List<dynamic> jobsArray = data['Jobs'] ?? [];

                  if (!jobsArray.contains(id)) {
                    // Update the array in Firestore using arrayUnion
                    await staffDocRef.update({
                      'Jobs': FieldValue.arrayUnion([id]),
                    });
                    showSnackBar(context, 'ID added successfully');
                  } else {
                    showSnackBar(
                        context, 'ID is already present in the Jobs array');
                  }
                }
              } else {
                showSnackBar(context,
                    "No Patient With this national id"); // Handle case when no document is found
              }
              // if (id != "") {
              //   // Update the array in Firestore using arrayUnion
              //   await FirebaseFirestore.instance
              //       .collection('Staff')
              //       .doc(globalcurrentUserId)
              //       .update({
              //     'Jobs': FieldValue.arrayUnion([id]),
              //   });
              //   print('National ID added to the array successfully');
              // } else {
              //   showSnackBar(context, "No Patient With this national id");
              // }
            } catch (error) {
              print('Error adding National ID to the array: $error');
            }
          }
        },
      ),
    );
  }
}

Future<void> deleteElemetInArray(String collectionPath, String documentId,
    String fieldPath, dynamic elementToRemove) async {
  try {
    // Get a reference to the document
    DocumentReference<Map<String, dynamic>> documentRef =
        FirebaseFirestore.instance.collection(collectionPath).doc(documentId);

    // Remove the specified element from the array
    documentRef.update({
      fieldPath: FieldValue.arrayRemove([elementToRemove])
    }).then((_) {
      print("Element removed successfully from array!");
    }).catchError((error) {
      print("Error removing element from array: $error");
    });
  } catch (e) {
    print("Error: $e");
  }
}
