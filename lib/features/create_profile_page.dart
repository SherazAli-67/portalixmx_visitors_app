import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_visitor_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_visitor_app/res/app_colors.dart';
import 'package:portalixmx_visitor_app/res/app_textstyles.dart';
import 'package:portalixmx_visitor_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_visitor_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';
import '../widgets/primary_btn.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _identificationTypeController =
      TextEditingController();

  final TextEditingController _licensePlatController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleColorTypeController =
      TextEditingController();

  final TextEditingController _purposeOfVisitController =
      TextEditingController();

  late ProfileProvider _provider;
  XFile? _imagePicked;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _identificationTypeController.dispose();
    _vehicleModelController.dispose();
    _licensePlatController.dispose();
    _vehicleColorTypeController.dispose();
    _purposeOfVisitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProfileProvider>(context);
    return ScreenWithBgLogo(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(color: Colors.white),
                  Text(AppLocalizations.of(context)!.createProfile, style: AppTextStyles.headingTextStyle),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.btnColor,
                      backgroundImage: _imagePicked != null ? FileImage(File(_imagePicked!.path)) : null,
                      child: _imagePicked != null ? null : Center(child: Icon(Icons.person, size: 50, color: Colors.white,)),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                      backgroundColor: Colors.white,
                      child: GestureDetector(onTap: _onPickImageTap, child: Icon(Icons.edit, color: AppColors.primaryColor,))
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(textController: _fullNameController, hintText: AppLocalizations.of(context)!.fullName),
                    AppTextField(textController: _emailController, hintText: AppLocalizations.of(context)!.email),
                    AppTextField(textController: _identificationTypeController, hintText: AppLocalizations.of(context)!.identificationTypeAndNumber),
                    Text(AppLocalizations.of(context)!.vehicleInformation, style: AppTextStyles.regularTextStyle,),
                    
                    AppTextField(textController: _licensePlatController, hintText: AppLocalizations.of(context)!.licensePlate),
                    AppTextField(textController: _vehicleModelController, hintText: AppLocalizations.of(context)!.vehicleModel),
                    AppTextField(textController: _vehicleColorTypeController, hintText: AppLocalizations.of(context)!.vehicleColor),
                    Text(AppLocalizations.of(context)!.purposeOfVisit, style: AppTextStyles.regularTextStyle,),
          
                    AppTextField(textController: _purposeOfVisitController, hintText: AppLocalizations.of(context)!.purposeOfVisit),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: PrimaryBtn(onTap: _onNextTap, btnText: AppLocalizations.of(context)!.next, isLoading: _provider.updatingProfile,),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onNextTap()async{

    String userName = _fullNameController.text.trim();
    // String email = _emailController.text.trim();
    String identificationType = _identificationTypeController.text.trim();
    String licensePlate = _licensePlatController.text.trim();
    // String vehicleModel = _vehicleModelController.text.trim();
    String vehicleColor = _vehicleColorTypeController.text.trim();
    // String purposeOfVisit = _purposeOfVisitController.text.trim();

    Map<String, dynamic> map = {
      'img' :_imagePicked!.path,
      'name' : userName,
      'mobile' : identificationType,
      "additionalDetails": {
        "vehicleName": '',
        "color":  vehicleColor,
        "licensePlate": licensePlate,
        "registrationNumber": '',
      },
      "emergencyContacts": []
    };

    bool result = await context.read<ProfileProvider>().updateUserProfile(data: map);
    if(result){
      // userProvider.setUserName(name: _userName);
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.profileInfoUpdated);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> MainMenuPage()), (val)=> false);
    }
  }

  void _onPickImageTap() async{
    final imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      _imagePicked = pickedImage;
      setState(() {});
    }
  }
}
