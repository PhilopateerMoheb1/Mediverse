import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediverse/Features/PatientDashboard/MedicalRecord/MedicalPrescriptionsScreen/data/models/medical_prescription_model.dart';
import 'package:mediverse/Features/PatientDashboard/MedicalRecord/MedicalPrescriptionsScreen/data/repos/medical_prescription_repo.dart';

import '../../../../../../Core/Errors/Failure.dart';

class MedicalPrescriptionRepoImpl extends MedicalPrescriptionRepo{
  var messages =
  FirebaseFirestore.instance; //.collection('medicalPrescriptions');
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  sendLabs({required String now_date, required String imageUrl}) {
    try {
      messages.collection('info_Patients/$currentUser/medical prescriptions').add({
        'createdAt': DateTime.now(),
        'pictureDate': now_date,
        'imageUrl' : imageUrl,
      });
    } on Exception catch (e) {

    }
  }

  @override
  Future<Either<Failure , List<MedicalPrescriptionModel>>> getLabs({required QuerySnapshot event}) async{
    try {
      List<MedicalPrescriptionModel> messageList = [];
      for (var doc in event.docs) {
        messageList.add(MedicalPrescriptionModel.fromJson(doc));
      }
      return right(messageList);
    } on Exception catch (e) {
      return left(ServerFailure(errMsg: 'Something went wrong, Try again'));
    }
  }

}