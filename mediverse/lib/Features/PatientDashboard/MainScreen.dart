import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mediverse/Constants/constant.dart';
import 'package:mediverse/Core/utils/Globals.dart';
import 'package:mediverse/Features/DoctorDashboard/ChatsList/presentation/Views/ChatsList.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/AppointmentDetailsScreen/presentation/Manager/FetechPatientCubit/fetechPatientCubit.dart';
import 'package:mediverse/Features/PatientDashboard/MedicalRecord/DrNotesScreen/data/models/NoteModel.dart';
import 'package:mediverse/Features/PatientDashboard/tabs/Appointment%20Tab.dart';

import 'Widgets/CustomAppbarMainScreenPatient.dart';
import 'tabs/MedicalBlogsTab.dart';
import 'tabs/MedicalRecordTab/presentation/Views/MedicalRecordTab.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'Middle'),
    Tab(text: 'RIGHT'),
    Tab(text: 'AFTERRIGHT'),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetechPatientInfoCubit>(context)
        .getPatientInforCubitFunction(globalcurrentUserId);
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        automaticallyImplyLeading: false,
        title: const CustomAppbarMainScreenPatient(),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              isScrollable: false,
              labelColor: kprimaryColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelStyle: const TextStyle(),
              indicatorColor: kprimaryColor,
              tabs: [
                Tab(
                  text: 'Booking',
                ),
                Tab(text: 'Record'),
                Tab(text: 'Blogs'),
                Tab(text: 'Chats'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AppointmentTab(),
                const MedicalRecordsTab(),
                MedicalBlogsTab(),
                ChatsList(
                  role: "Patient",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
