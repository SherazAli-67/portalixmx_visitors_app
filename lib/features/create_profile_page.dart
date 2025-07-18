import 'package:flutter/material.dart';
import 'package:portalixmx_visitor_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_visitor_app/res/app_colors.dart';
import 'package:portalixmx_visitor_app/res/app_textstyles.dart';
import 'package:portalixmx_visitor_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_visitor_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';

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
                      child: Center(child: Icon(Icons.person, size: 50, color: Colors.white,)),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, color: AppColors.primaryColor,),
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
                      child: PrimaryBtn(onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> MainMenuPage()), (val)=> false);
                      }, btnText: AppLocalizations.of(context)!.next),
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
}
