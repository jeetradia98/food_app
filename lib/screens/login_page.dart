import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_app/blocs/auth/auth_bloc.dart';
import 'package:food_app/utils/base_colors.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:food_app/utils/base_images.dart';
import 'package:food_app/utils/base_strings.dart';
import 'package:food_app/widgets/custom_buttons.dart';
import 'package:food_app/widgets/custom_textfield.dart';

import '../../utils/base_methods.dart';
import '../../utils/routes.dart';
import '../widgets/platform_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  Rx<String?> emailError = Rx<String?>(null);
  Rx<String?> phoneError = Rx<String?>(null);
  final formKey = GlobalKey<FormState>();

  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // og('$state in login page');
            if (state is AuthCompleted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.screenSaver,
                (route) => false,
                // arguments: {
                //   BaseApiConstants.url:
                //       state.response.screenSaverMasters!.first.imagePath!
                // },
              );
              // Get.offAllNamed(Routes.screenSaver, arguments: );
            }
          },
          builder: (context, state) {
            if (state is AuthInProgress) {
              return const PlatformIndicator(
                message: 'Authenticating.....',
              );
            } else if (state is AuthCompleted) {
              return const SizedBox.shrink();
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        40.0.toVSB,
                        Center(
                          child: ClipOval(
                            child: FadeInImage(
                              image: const NetworkImage(
                                  'https://picsum.photos/400'),
                              width: 0.40.sw,
                              height: 0.40.sw,
                              placeholder: const AssetImage(BaseImages.shimmer),
                            ),
                          ),
                        ),
                        30.h.toVSB,
                        CustomTextField(
                          controller: emailController,
                          label: BaseStrings.email,
                          focus: emailFocus,
                          error: emailError,
                          // fieldValidator: (s) => validateEmail(email: s),
                          inputAction: TextInputAction.next,
                        ),
                        20.h.toVSB,
                        CustomTextField(
                          controller: phoneController,
                          label: BaseStrings.password,
                          focus: phoneFocus,
                          error: phoneError,
                          // fieldValidator: (s) => validatePassword(password: s),
                        ),
                        90.h.toVSB,
                        CustomElevatedButton(
                          onPressed: () => loginPress(context),
                          title: BaseStrings.login,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          textStyle:
                              Theme.of(context).textTheme.button?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: BaseColors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> loginPress(context) async {
    emailFocus.unfocus();
    phoneFocus.unfocus();

    var emailString = emailController.text.trim();
    var phoneString = phoneController.text.trim();

    emailError.value = validateEmail(email: emailString);
    phoneError.value = validatePassword(password: phoneString);

    var validate = emailError.value == null && phoneError.value == null;

    if (validate) {
      authBloc.add(LoginEvent(
          password: phoneController.text.trim(),
          email: emailController.text.trim()));
    }
  }

  TextStyle get pink14 {
    return TextStyle(
      color: BaseColors.pink,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    );
  }
}
