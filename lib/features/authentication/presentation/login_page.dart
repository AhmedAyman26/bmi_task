import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/cache_helper.dart';
import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/core/widgets/app_button.dart';
import 'package:bmi_task/core/widgets/app_text_form_field.dart';
import 'package:bmi_task/core/widgets/show_loading_widget.dart';
import 'package:bmi_task/features/authentication/presentation/authentication_cubit.dart';
import 'package:bmi_task/features/authentication/presentation/authentication_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(injector()),
      child: const SignInPageBody(),
    );
  }
}

class SignInPageBody extends StatefulWidget {
  const SignInPageBody({super.key});

  @override
  State<SignInPageBody> createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<SignInPageBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationStates>(
      listener: (context, state) async {
        if (state.authenticationState == RequestStatus.loading) {
          showLoading(context);
        }
        if (state.authenticationState == RequestStatus.success) {
          await CacheHelper.saveData(key: 'userId', value: state.userId);
          if(mounted) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Container(),), (
                route) => false);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextFormField(
                        controller: emailController,
                        label: 'email address',
                        prefix: const Icon(Icons.email),
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextFormField(
                        controller: passwordController,
                        label: 'password',
                        prefix: const Icon(Icons.lock),
                        type: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppButton(
                        text: 'login',
                        function: () async {
                          BlocProvider.of<AuthenticationCubit>(context)
                              .signIn();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have account?',
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('RegisterNow'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
