import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:whatsapp_app/features/app/theme/style.dart';
import 'package:whatsapp_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp_app/features/user/presentation/pages/initial_profile_submit_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Verifier votre code OTP",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: tabColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Entrez votre code OTP pour que WhatsApp clone puisse verifier votre numero et vous permettre l'acces a l'application",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _pinCodeWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _submitSmsCode,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    color: tabColor, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    "Suivant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//*PINCODE WIDGET
  Widget _pinCodeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          PinCodeFields(
            controller: _otpController,
            length: 6,
            activeBorderColor: tabColor,
            onComplete: (String pinCode) {},
          ),
          const Text("Entrez votre code a 6 chiffres"),
        ],
      ),
    );
  }

//* SUBMIT SMS CODE
  _submitSmsCode() {
    print("otpCode  ${_otpController.text} ");
    if (_otpController.text.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context)
          .submitSmsCode(smsCode: _otpController.text);
    }
  }
}
