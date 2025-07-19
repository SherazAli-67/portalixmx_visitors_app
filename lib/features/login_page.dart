import 'package:flutter/material.dart';
import 'package:portalixmx_visitor_app/features/create_profile_page.dart';
import 'package:portalixmx_visitor_app/providers/auth_provider.dart';
import 'package:portalixmx_visitor_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_visitor_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

import '../../../res/app_textstyles.dart';
import '../widgets/bg_logo_screen.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AuthProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(AppLocalizations.of(context)!.visitorLogin, style: AppTextStyles.headingTextStyle),
            const SizedBox(height: 16,),
            AppTextField(textController: _emailController, hintText: AppLocalizations.of(context)!.email,),
            AppTextField(textController: _passwordController, hintText: AppLocalizations.of(context)!.password, isPassword: true,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onLoginTap, btnText: AppLocalizations.of(context)!.login),
            ),
            TextButton(onPressed: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> OtpPage()));
            }, child: Text(AppLocalizations.of(context)!.forgetPassword, style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }

  void _onLoginTap() async{
    String emailAddress = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if(emailAddress.isEmpty || password.isEmpty){
      return;
    }

    bool result = await provider.onLoginTap(email: emailAddress, password: password);
    if(result){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> CreateProfilePage()), (val)=> false);
    }
  }
}
