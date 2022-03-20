import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/layout/home_screen.dart';
import 'package:scroll/modules/register/cubit/cubit.dart';
import 'package:scroll/modules/register/cubit/states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (contextProfile) {
            //     return BlocProvider.value(
            //       value: MasterCubit.get(context)..getUserData()..getUsersDataPosts(),
            //       child: const Home(),
            //     );
            //   },
            // ));
            MasterCubit.get(context).getUserData().then((value) {
              MasterCubit.get(context).getUsersDataPosts().then((value) {
                MasterCubit.get(context).getChatUsers().then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (route) {
                      return false;
                    },
                  );
                });
              });
            });
          } else if (state is CreateUserErrorState ||
              state is RegisterErrorState) {
            Fluttertoast.showToast(
              msg: 'error please try again',
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
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) return 'please enter your name';
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          obscureText: RegisterCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) return 'password is too short';
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(
                                RegisterCubit.get(context).suffix,
                              ),
                              onTap: () {
                                RegisterCubit.get(context)
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
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 40.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: user != null
                                  ? null
                                  : () async {
                                      await _googleSignIn
                                          .signIn()
                                          .then((value) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Home(),
                                          ),
                                          (route) {
                                            return false;
                                          },
                                        );
                                      });
                                      setState(() {});
                                    },
                              child: const Text(
                                'G+',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.facebook_outlined,
                                size: 25,
                              ),
                            ),
                          ],
                        )
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
//
//   class GoogleLoginApp extends StatefulWidget {
//   const GoogleLoginApp({ Key? key }) : super(key: key);
//
//   @override
//   _GoogleLoginAppState createState() => _GoogleLoginAppState();
//   }
//
//   class _GoogleLoginAppState extends State<GoogleLoginApp> {
//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//
//   @override
//   Widget build(BuildContext context) {
//   GoogleSignInAccount? user = _googleSignIn.currentUser;
//
//   return MaterialApp(
//   home: Scaffold(
//   appBar: AppBar(
//   title: Text('Google Demo (Logged ' + (user == null ? 'out' : 'in') + ')'),
//   ),
//   body: Center(
//   child: Column(
//   children: [
//   ElevatedButton(child: Text('Sign In'),
//   onPressed: user != null ? null : () async {
//   await _googleSignIn.signIn();
//   setState(() {});
//   }),
//   ElevatedButton(child: Text('Sign Out'),
//   onPressed: user == null ? null : () async {
//   await _googleSignIn.signOut();
//   setState(() {});
//   }),
//   ],
//   ),
//   ),
//   ),
//   );
//   }
//   }
// }
