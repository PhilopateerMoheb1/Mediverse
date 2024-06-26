import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediverse/Constants/Themes.dart';
import 'package:mediverse/Features/DoctorDashboard/DoctorChat/data/repos/getDoctorInfoRepoImp.dart';
import 'package:mediverse/Features/DoctorDashboard/DoctorChat/presentation/Manager/getNameAndPhotoCubit/GetDoctorInfoCubit.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/DrInformation.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/PriceOfBookingWidget.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/SlotsAddWidgetRow.dart';
import 'package:mediverse/Features/StaffDashboard/Widgets/SlotsWidget.dart';

class HospitalStaffManagementScreenBody extends StatelessWidget {
  const HospitalStaffManagementScreenBody({
    super.key,
    required this.textEditingController,
    required this.monthName,
    required this.id,
    required this.doctorOrgName,
  });

  final TextEditingController textEditingController;
  final String monthName;
  final String id;
  final String doctorOrgName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 12),
            child: BlocProvider(
              create: (context) => GetDoctorInfoCubit(GetDoctorInfoRepoImp()),
              child: DrInformation(
                id: id,
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 0, 12),
            child: PriceOfBookingWidget(
              textEditingController: textEditingController,
              id: id,
              orgName: doctorOrgName,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
            child: SlotsAddWidgetRow(
              orgName: doctorOrgName,
              doctorId: id,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 7, 12, 0),
            child: Text(
              'For this Month($monthName)',
              style: Themes.bodyMedium.copyWith(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
          child: SlotsWidget(
            id: id,
            orgName: doctorOrgName,
          ),
        ),
      ],
    );
  }
}
