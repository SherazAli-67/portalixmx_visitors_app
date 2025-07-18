import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_icons.dart';
import '../../res/app_textstyles.dart';
import '../../widgets/primary_btn.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';

class QRCodePage extends StatelessWidget{
  const QRCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
        child: Column(
          spacing: 15,
          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(child: Icon(Icons.person, color: Colors.white,),),
                ),
                Text(AppLocalizations.of(context)!.welcomeMessage("Alex"), style: AppTextStyles.regularTextStyle,)
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildInfoItemWidget(
                    title: AppLocalizations.of(context)!.name, subtitle: 'Alex',showDivider: true,),
                ),
                Expanded(
                    child: _buildInfoItemWidget(
                      title: AppLocalizations.of(context)!.contact, subtitle: '+91 1335789',showDivider: true,)
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildInfoItemWidget(
                    title: AppLocalizations.of(context)!.date, subtitle: 'Sep 20, 2024',),
                ),
                Expanded(
                    child: _buildInfoItemWidget(
                      title: AppLocalizations.of(context)!.time, subtitle: '10:00AM - 06:00PM',)
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Text(AppLocalizations.of(context)!.qrCode, style: AppTextStyles.visitorDetailTitleTextStyle.copyWith(color: Colors.white),),
            Image.asset(AppIcons.icQRCode),
            const Spacer(),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 40),
              width: double.infinity,
              child: PrimaryBtn(
                onTap: () {}, btnText: AppLocalizations.of(context)!.shareKey, color: AppColors.primaryColor,),
            )
          ],
        )
    );
  }


  Widget _buildInfoItemWidget({required String title, required String subtitle, bool showDivider = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.visitorDetailTitleTextStyle.copyWith(color: Colors.white)),
        Text(subtitle, style: AppTextStyles.visitorDetailSubtitleTextStyle.copyWith(fontSize: 14, color: Colors.white),),
        const SizedBox(height: 20,),
        if(showDivider)
          Divider(color: AppColors.dividerColor,)
      ],
    );
  }
}