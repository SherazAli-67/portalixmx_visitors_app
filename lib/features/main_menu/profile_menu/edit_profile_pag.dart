import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/primary_btn.dart';

class EditProfilePage extends StatelessWidget{
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BgGradientScreen(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 65.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text("Profile", style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 40,)
            ],
          ),
        ),

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 65,
                    right: 0,
                    left: 0,
                    child: Card(
                        color: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        child: Padding(padding: EdgeInsets.only(top: 100, right: 15, left: 15,),
                          child: SizedBox(
                            height: size.height*0.7,
                            child: ListView(
                              children: [
                                EditProfileItemWidget(
                                  title: "Name", value: "Muhammad Ali", onTap: () {},),
                                EditProfileItemWidget(
                                  title: "Email", value: "imtiazkhansoomro@gmail.com", onTap: () {},),
                                EditProfileItemWidget(
                                  title: "Phone", value: "+92 3072215500", onTap: () {},),
                                EditProfileItemWidget(
                                  title: "Password", value: "*********", onTap: () {},),

                                const SizedBox(height: 30,),
                                Text("Vehicle Information", style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),),

                                EditProfileItemWidget(
                                  title: "Vehicle Name", value: "Motorolla Car", onTap: () {},),
                                EditProfileItemWidget(title: "Color", value: "Red", onTap: () {},),
                                EditProfileItemWidget(
                                  title: "License Plate Number", value: "KL76 HJ 8979", onTap: () {},),
                                Padding(
                                  padding: EdgeInsets.only(top: 40,bottom: size.height*0.05),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: PrimaryBtn(onTap: () {}, btnText: "Update"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    )),
                Column(
                  spacing: 5,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: CachedNetworkImageProvider(AppIcons.icUserImageUrl),
                      ),
                    ),
                    Text("Muhammad Ali", style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.black),),
                    InkWell(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                        },
                        child: Text("View Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class EditProfileItemWidget extends StatelessWidget {
  const EditProfileItemWidget({
    super.key,
    required String title, required String value, required VoidCallback onTap,
  }): _title = title, _value = value, _onTap = onTap;
  final String _title;
  final String _value;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_title, style: AppTextStyles.editProfileHeadingTextStyle,),
              InkWell(onTap: _onTap, child: SvgPicture.asset(AppIcons.icProfileEdit))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_value, style: AppTextStyles.editProfileSubHeadingTextStyle,),
              Divider()
            ],
          )


        ],
      ),
    );
  }
}