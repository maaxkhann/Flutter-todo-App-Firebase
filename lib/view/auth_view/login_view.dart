import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/view/auth_view/signup_view.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import '../constant_widgets/constant_button.dart';
import '../constant_widgets/constant_textfield.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBGColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.grey.withOpacity(0.3),
            //  Colors.blueGrey,
              Colors.grey.withOpacity(0.5),
            ],
            )
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              //    const Icon(Icons.arrow_back_ios, ),
                  const Text('Welcome Back!', style: kHead1,),
                  const Text('Enter Your Email & Password..', style: kHead2,),
                  SizedBox(height: size.height * 0.08,),
                  ConstantTextField(controller: emailController, hintText: 'Enter Email', suffixIcon: Icons.email),
                  SizedBox(height: size.height * 0.04,),
                  ValueListenableBuilder(valueListenable: isPasswordVisible,
                      builder: (ctx, value, child) {
                    return ConstantTextField(controller: passwordController, hintText: 'Enter Password',
                      obscureText: !isPasswordVisible.value,
                        suffixIcon: value == true ? Icons.visibility : Icons.visibility_off, onTapSuffixIcon: () {
                      isPasswordVisible.value = !isPasswordVisible.value;
                    },);
                      }),
                  SizedBox(height: size.height * 0.1,),
                  ConstantButton( onTap: () {
                    if(emailController.text.isEmpty || passwordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please fill both the fields');
                      return;
                    }else {
                      authViewModel.loginUser(context, emailController.text.trim(), passwordController.text.trim());
                    }
                  },
                    text: 'Login', buttonColor: kButtonColor, textColor: kWhite,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have account?', style: kHead2,),
                      TextButton(onPressed: () => Get.off(()=> SignUpView()),
                          child: const Text('Sign Up', style: TextStyle(fontStyle: FontStyle.italic),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
