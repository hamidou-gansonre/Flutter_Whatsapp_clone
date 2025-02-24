import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_app/features/app/const/app_const.dart';
import 'package:whatsapp_app/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_app/features/app/home/home_page.dart';
import 'package:whatsapp_app/features/app/theme/style.dart';
import 'package:whatsapp_app/features/user/domaine/entities/user_entity.dart';
import 'package:whatsapp_app/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp_app/storage/storage_provider.dart';

class InitialProfileSubmitPage extends StatefulWidget {
  final String phoneNumber;
  const InitialProfileSubmitPage({super.key, required this.phoneNumber});

  @override
  State<InitialProfileSubmitPage> createState() =>
      _InitialProfileSubmitPageState();
}

class _InitialProfileSubmitPageState extends State<InitialProfileSubmitPage> {
  final TextEditingController _usernameController = TextEditingController();
  File? _image;
  bool _isProfileUpdating = false;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No Image has been selected");
        }
      });
    } catch (e) {
      toast("Une erreur est survenue $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    "Profile Info",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Ecrivez votre nom d'utilisateur et choississez une photo (Optional)",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: selectImage,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: profileWidget(image: _image),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 1.5),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: tabColor, width: 1.5))),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: "Nom d'Utilisateur",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: submitProfileInfo,
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    color: tabColor, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    "Suivant",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*submit profile info
  void submitProfileInfo() {
    if(_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
        file: _image!,
        onComplete: (onProfileUpdateComplete){
        setState(() {
          _isProfileUpdating = onProfileUpdateComplete;
        });
      },

      ).then((profileImageUrl){
        _profileInfo(profileUrl: profileImageUrl) ;
      });
    } else
      {
        _profileInfo(profileUrl: "") ;
      }
  }

  //*Profile Info
  void _profileInfo({String? profileUrl}){
    if(_usernameController.text.isNotEmpty){
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
        user: UserEntity(
          email: "",
          username: _usernameController.text,
          phoneNumber: widget.phoneNumber,
          status: "Salut! , j'utilise WhatsApp clone",
          isOnline: false,
          profileUrl: profileUrl,
        )
      );
    }
  }
}
