import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/text_styles.dart';
import 'package:to_do_app/view/auth_view/login_view.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import '../constant_widgets/constant_button.dart';
import '../constant_widgets/constant_textfield.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);

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
                Colors.grey.withOpacity(0.4),
                //  Colors.blueGrey,
                Colors.grey.withOpacity(0.5),
              ],
              )
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //    const Icon(Icons.arrow_back_ios, ),
                  const Text('Create Account', style: kHead1,),
                  SizedBox(height: size.height * 0.05,),
                  ConstantTextField(controller: nameController, hintText: 'Enter Name', prefixIcon: Icons.person),
                  SizedBox(height: size.height * 0.04,),
                  ConstantTextField(controller: emailController, hintText: 'Enter Email', prefixIcon: Icons.email),
                  SizedBox(height: size.height * 0.04,),
                  ValueListenableBuilder(valueListenable: isPasswordVisible,
                      builder: (ctx, value, child) {
                        return ConstantTextField(controller: passwordController, hintText: 'Enter Password',
                          obscureText: !isPasswordVisible.value, prefixIcon: Icons.password,
                          suffixIcon: value == true ? Icons.visibility : Icons.visibility_off, onTapSuffixIcon: () {
                            isPasswordVisible.value = !isPasswordVisible.value;
                          },);
                      }),
                  SizedBox(height: size.height * 0.04,),
                  ValueListenableBuilder(valueListenable: isConfirmPasswordVisible,
                      builder: (ctx, value, child) {
                        return ConstantTextField(controller: confirmPasswordController, hintText: 'Confirm Password',
                          obscureText: !isConfirmPasswordVisible.value, prefixIcon: Icons.password,
                          suffixIcon: value == true ? Icons.visibility : Icons.visibility_off, onTapSuffixIcon: () {
                            isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
                          },);
                      }),
                  SizedBox(height: size.height * 0.1,),
                  ConstantButton( onTap: () {
                    if(nameController.text.isEmpty || emailController.text.isEmpty
                        || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please fill all the fields');
                      return;
                    }else if(passwordController.text != confirmPasswordController.text) {
                      Fluttertoast.showToast(msg: 'Password not matched');
                      return;
                    }else {
                      authViewModel.createUser(context, nameController.text.trim(), emailController.text.trim(),
                          passwordController.text.trim());
                    }
                  },
                    text: 'Sign Up', buttonColor: kButtonColor, textColor: kWhite,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have account?', style: kHead2,),
                      TextButton(onPressed: () => Get.off(()=> LoginView()),
                          child: const Text('Login', style: TextStyle(fontStyle: FontStyle.italic,),))
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
