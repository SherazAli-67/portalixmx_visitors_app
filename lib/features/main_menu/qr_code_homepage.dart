import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portalixmx_visitor_app/helpers/datetime_helper.dart';
import 'package:portalixmx_visitor_app/providers/home_provider.dart';
import 'package:portalixmx_visitor_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_icons.dart';
import '../../res/app_textstyles.dart';
import '../../widgets/primary_btn.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';

class QRCodePage extends StatefulWidget{
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  late HomeProvider _provider;
  bool _loadingSave = false;
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<HomeProvider>(context);
    return _provider.loadingProfile ? Center(child: LoadingWidget(),) : Stack(
      children: [
        SingleChildScrollView(
            padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
            child: Column(
              spacing: 15,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.btnColor,
                      backgroundImage: CachedNetworkImageProvider(
                          _provider.user!.image.replaceAll('public', AppConstants.imageBaseUrl))
                    ),
                    Text(AppLocalizations.of(context)!.welcomeMessage(_provider.user!.name), style: AppTextStyles.regularTextStyle,)
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: _buildInfoItemWidget(
                        title: AppLocalizations.of(context)!.name, subtitle: _provider.user!.name,showDivider: true,),
                    ),
                    Expanded(
                        child: _buildInfoItemWidget(
                          title: AppLocalizations.of(context)!.contact, subtitle: _provider.user!.mobile,showDivider: true,)
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: _buildInfoItemWidget(
                        title: AppLocalizations.of(context)!.date, subtitle: DateTimeFormatHelpers.formatDateTime(_provider.user!.createdAt),),
                    ),
                    Expanded(
                        child: _buildInfoItemWidget(
                          title: AppLocalizations.of(context)!.time, subtitle: DateTimeFormatHelpers.formatTime(TimeOfDay.fromDateTime(_provider.user!.createdAt)),)
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.qrCode, style: AppTextStyles.visitorDetailTitleTextStyle.copyWith(color: Colors.white),),
                Image.asset(AppIcons.icQRCode),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 40),
                  width: double.infinity,
                  child: PrimaryBtn(
                    onTap: _shareQrCode, btnText: AppLocalizations.of(context)!.shareKey, color: AppColors.primaryColor,),
                )
              ],
            )
        ),
        if(_loadingSave)
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: double.infinity,
            child: LoadingWidget(),
          )
      ],
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

  void _shareQrCode() async{
    String userName = _provider.user!.name;
    try{
      setState(() => _loadingSave = true);
      Uint8List? capturedImage = await _takeScreenshot();
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/$userName.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(capturedImage!);

      // Share the image
      await SharePlus.instance.share(
        ShareParams(
          files:  [XFile(imagePath)],
          text: 'Visitor: ${_provider.user!.name} Key',
        )
      );
    }catch(e){
      debugPrint("Failed to share QR Code: ${e.toString()}");
    }
    setState(() => _loadingSave = false);
  }

  Future<Uint8List?> _takeScreenshot() async{
    Uint8List? uint8List;
    ScreenshotController screenshotController = ScreenshotController();

    try{
      uint8List = await screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
            context, _buildQRImage()
        ),
        delay: const Duration(seconds: 1), // Optional delay to ensure rendering
      );
    }catch(e){
      debugPrint('Error while taking screenshot: ${e.toString()}');
    }
    return uint8List;
  }

  Widget _buildQRImage() {
    final map = {
      'isVisitor' : true,
      'userID' : _provider.user!.id
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: 200,
          child: QrImageView(data: jsonEncode(map)),
        ),
      ),
    );
  }
}