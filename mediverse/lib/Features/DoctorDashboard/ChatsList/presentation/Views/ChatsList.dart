import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mediverse/Constants/Themes.dart';
import 'package:mediverse/Constants/constant.dart';
import 'package:mediverse/Core/utils/Globals.dart';
import 'package:mediverse/Features/DoctorDashboard/widgets/ChatHead.dart';

class ChatsList extends StatelessWidget {
  ChatsList({
    super.key,
    required this.role,
  });
  CollectionReference chatHistory =
      FirebaseFirestore.instance.collection('ChatHistory');
  final String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: kprimaryColor,
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.chevron_left,
      //       color: Colors.white,
      //       size: 24,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   title: Text(
      //     'Chats',
      //     style: Themes.headlineMedium.copyWith(
      //       color: backgroundColor,
      //     ),
      //   ),
      //   actions: const [],
      //   centerTitle: true,
      //   elevation: 2,
      // ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            role == "Patient"
                ? StreamBuilder<QuerySnapshot>(
                    stream: chatHistory
                        .orderBy(kCreatedAt, descending: true)
                        .where('patient_id', isEqualTo: globalcurrentUserId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final chats = snapshot.data!.docs;
                      return Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                          child: ListView.builder(
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final doctorId = chats[index]
                                  .get('doctor_id'); // Extract doctor_id

                              // Use doctorId for further processing or display
                              return ChatHead(
                                patient_id: globalcurrentUserId,
                                doctor_id: doctorId,
                                chatterRole: "DoctorProfile",
                              ); // Assuming ChatHead takes doctorId
                            },
                          ),
                        ),
                      );
                    })
                : StreamBuilder<QuerySnapshot>(
                    stream: messages
                        .orderBy(kCreatedAt, descending: true)
                        .where('doctor_id', isEqualTo: globalcurrentUserId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return Center(child: SpinKitCircle());
                      }

                      final chats = snapshot.data!.docs;
                      return Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                          child: ListView.builder(
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final patient_id = chats[index]
                                  .get('patient_id'); // Extract doctor_id

                              // Use doctorId for further processing or display
                              return ChatHead(
                                patient_id: patient_id,
                                doctor_id: globalcurrentUserId,
                                chatterRole: "Patient_Profile",
                              ); // Assuming ChatHead takes doctorId
                            },
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
