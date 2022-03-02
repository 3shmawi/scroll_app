import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/home_screen.dart';
import 'package:scroll/modules/login/cubit/cubit.dart';
import 'package:scroll/modules/login/cubit/states.dart';
import 'package:scroll/modules/register/register_screen.dart';

import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: MasterCubit.get(context)
                    ..getUserData
                    ..getUsersDataPosts,
                  child: const Home(),
                ),
              ),
                  (route) {
                return false;
              },
            );
          } else if (state is LoginErrorState) {
            Fluttertoast.showToast(
              msg: state.error,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              fontSize: 16.0,
              toastLength: Toast.LENGTH_LONG,
              webShowClose: true,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: LoginCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) return 'password is too short';
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(
                                LoginCubit.get(context).suffix,
                              ),
                              onTap: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 40.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              color: Colors.blue,
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                child: const Text('REGISTER'))
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
      ),
    );
  }
}
