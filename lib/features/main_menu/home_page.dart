import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_icons.dart';
import '../../res/app_textstyles.dart';
import '../../widgets/primary_btn.dart';

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
                Text("Welcome Alex", style: AppTextStyles.regularTextStyle,)
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildInfoItemWidget(
                    title: 'Date', subtitle: 'Sep 20, 2024',showDivider: true,),
                ),
                Expanded(
                    child: _buildInfoItemWidget(
                      title: 'Time', subtitle: '10:00AM - 06:00PM',showDivider: true,)
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: _buildInfoItemWidget(
                    title: 'Requested Time', subtitle: 'Sep 20, 2024',),
                ),
                Expanded(
                    child: _buildInfoItemWidget(
                      title: 'Access Approved Date', subtitle: '10:00AM - 06:00PM',)
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Text("QR CODE", style: AppTextStyles.visitorDetailTitleTextStyle.copyWith(color: Colors.white),),
            Image.asset(AppIcons.icQRCode),
            const Spacer(),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 40),
              width: double.infinity,
              child: PrimaryBtn(
                onTap: () {}, btnText: "Share Key", color: AppColors.primaryColor,),
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