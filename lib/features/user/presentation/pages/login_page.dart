import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_app/features/app/const/app_const.dart';
import 'package:whatsapp_app/features/app/home/home_page.dart';
import 'package:whatsapp_app/features/app/theme/style.dart';
import 'package:whatsapp_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatsapp_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp_app/features/user/presentation/pages/initial_profile_submit_page.dart';
import 'package:whatsapp_app/features/user/presentation/pages/otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("226");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialListenerState) {
        if(credentialListenerState is CredentialSuccess){
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if(credentialListenerState is CredentialFailure){
          toast("Something went wrong");
        }
      },
      builder: (context, credentialBuilderState) {
        if(credentialBuilderState is CredentialLoading){
          return const Center(child: CircularProgressIndicator(color: tabColor,),);
        }
        if(credentialBuilderState is CredentialPhoneAuthSmsCodeReceived){
          return const OtpPage();
        }
        if(credentialBuilderState is CredentialPhoneAuthProfileInfo){
          return InitialProfileSubmitPage(phoneNumber: _phoneNumber);
        }
        if(credentialBuilderState is CredentialSuccess){
          return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if(authState is Authenticated){
                  return HomePage(uid: authState.uid);
                }
                return _bodyWidget();
              },
          );
        }
        return _bodyWidget();
      },
    );
  }

  //BODY WIDGET
  _bodyWidget(){
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                        "Verifier votre numero",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tabColor),
                      ),
                    ),
                    const Text(
                      "WhatsApp clone va vous envoyer un SMS de verificarion, Entrez le code indicateur du pays avant le numero.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                      onTap: _openFilteredCountryPickerDialog,
                      title: _buildDialogItem(_selectedFilteredDialogCountry),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1.50, color: tabColor)),
                          ),
                          width: 80,
                          height: 42,
                          alignment: Alignment.center,
                          child: Text(_selectedFilteredDialogCountry.phoneCode),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 1.5),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: tabColor, width: 1.5)),
                            ),
                            child: TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                  hintText: "Phone Number",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _submitVerifuPhoneNumber,
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
        ),);
  }

  //_openFilteredCountryPickerDialog
  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
              data: Theme.of(context).copyWith(primaryColor: tabColor),
              child: CountryPickerDialog(
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: tabColor,
                searchInputDecoration:
                    const InputDecoration(hintText: "search"),
                isSearchable: true,
                title: const Text("Selectionner votre indicateur"),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

// build Diaog Item
  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: tabColor, width: 1.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(" +${country.phoneCode}"),
          Expanded(
            child: Text(
              " ${country.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  //SUBMIT VERIFY PHONE NUMBER
void _submitVerifuPhoneNumber(){
    if(_phoneController.text.isNotEmpty){
      _phoneNumber="+$_countryCode${_phoneController.text}";
      print("Phone Number : $_phoneNumber");
      BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(phoneNumber: _phoneNumber);
    } else {
      toast("Veuillez saisir votre numero");
    }

}

//TOAST

}
