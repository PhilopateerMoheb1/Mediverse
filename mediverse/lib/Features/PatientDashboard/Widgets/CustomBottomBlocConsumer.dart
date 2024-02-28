import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/BookingScreen/data/models/PaymentIndentInputModel.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/BookingScreen/presentation/Manager/Payment_Cubit/Payment_Stripe_Cubit.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/BookingScreen/presentation/Manager/Payment_Cubit/Payment_Stripe_States.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/BookingScreen/presentation/Views/BookingScreen.dart';
import 'package:mediverse/Features/PatientDashboard/Appointment/BookingScreen/presentation/Views/Thank_you_Screen.dart';
import 'package:mediverse/Features/PatientDashboard/Widgets/ConfirmButton.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentStripeCubit, PaymentStripeState>(
      listener: (context, state) {
        if (state is PaymentStripeSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }
        if (state is PaymentStripeFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
              content: Text(
            state.errMessage,
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return ConfirmButton(
          text: "Continue",
          isLoading: state is PaymentStripeLoading ? true : false,
          onTap: () {
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
                    //7ottttttttttttttt hnaaaaaaaaaaaaaaaa al Customerrrrrrrrrrrrrrrrrr idddddddddddddddddd ali fe  fire store
                    amount: '100',
                    currency: 'egp',
                    customerId: 'cus_Pe80vi7rQ3kLfY');
            BlocProvider.of<PaymentStripeCubit>(context)
                .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
        );
      },
    );
  }
}