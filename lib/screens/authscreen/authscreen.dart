import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = Auth();
  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  final userPhoneController = TextEditingController();

  final userNameKey = const Key('userNameKey');

  final emailKey = const Key('emai' 'l.Key');

  final passwordKey = const Key('password');

  final passwordConfirmKey = const Key('passwordConfirm');

  final userPhoneKey = const Key('userPhoneKey');

  final authFormKey = GlobalKey<FormState>();

  bool signIn = true;

  void save(Auth auth, StateManagment team) {
    if (authFormKey.currentState!.validate()) {
      authFormKey.currentState!.save();
      if (signIn) {
        auth.signIn();
      } else {
        auth.register(
          userNameController.text,
          userPhoneController.text,
          team.userDropDownBottonValue as String,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chosenTeam = Provider.of<StateManagment>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              height: size.height,
              child: Form(
                key: authFormKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * .1,
                          ),
                          SizedBox(
                            child: Image.asset('assets/logo.jpg'),
                            height: size.height * .2,
                          ),
                          SizedBox(
                            height: size.height * .075,
                          ),
                          if (!signIn)
                            AddPatientTextField(
                                label: 'اسم المستخدم',
                                controller: userNameController,
                                tKey: userNameKey,
                                save: (v) {},
                                validate: (v) {
                                  if (v.length < 2) {
                                    return 'ادخل اسم مستخدم صحيح';
                                  }
                                },
                                multiline: false),
                          AddPatientTextField(
                            label: 'الايميل',
                            controller: emailController,
                            tKey: emailKey,
                            multiline: false,
                            save: (v) {
                              auth.setEmail(v);
                            },
                            validate: (String v) {
                              if (!v.endsWith('.com') && !v.contains('@')) {
                                return 'ادخل ايميل صحيح';
                              }
                            },
                          ),
                          AddPatientTextField(
                            invisible: true,
                            label: 'كلمة السر',
                            controller: passwordController,
                            tKey: passwordKey,
                            multiline: false,
                            save: (v) {
                              auth.setPassword(v);
                            },
                            validate: (v) {
                              if (v.length < 8) {
                                return 'ادخل علي الاقل 8 حروف او ارقام';
                              }
                            },
                          ),
                          if (!signIn)
                            AddPatientTextField(
                              invisible: true,
                              label: 'تأكيد كلمة السر',
                              controller: passwordConfirmController,
                              tKey: passwordConfirmKey,
                              multiline: false,
                              save: (v) {},
                              validate: (v) {
                                if (passwordConfirmController.text !=
                                    passwordController.text) {
                                  return 'كلمة السر غير متشابهة';
                                }
                              },
                            ),
                          if (!signIn)
                            AddPatientTextField(
                                label: 'رقم التليفون',
                                controller: userPhoneController,
                                tKey: userPhoneKey,
                                save: (v) {},
                                validate: (String v) {
                                  if ((!(v.startsWith('01')) &&
                                      !(v.length == 10 || v.length == 11))) {
                                    return 'ادخل رقم هاتف صحيح';
                                  }
                                },
                                multiline: false),
                          if (!signIn)
                            Consumer<StateManagment>(
                              builder: (context, stateManagment, _) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        width: 1, color: Colors.greenAccent),
                                  ),
                                  elevation: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: DropdownButton(
                                      isDense: true,
                                      elevation: 50,
                                      // focusColor: Colors.white,
                                      underline: Container(),
                                      value: stateManagment
                                          .userDropDownBottonValue,
                                      isExpanded: true,
                                      hint: const Text('اختر التخصص'),
                                      onChanged: (v) => stateManagment
                                          .setUserDropDownBottonValue(
                                              v as String),
                                      items: List.generate(
                                        team.length,
                                        (index) => DropdownMenuItem(
                                          child: Text(
                                            team[index],
                                          ),
                                          value: team[index],
                                        ),
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                                onPressed: () => save(
                                      auth,
                                      chosenTeam,
                                    ),
                                child: (signIn)
                                    ? const Text('تسجيل الدخول')
                                    : const Text('التسجيل')),
                          ),
                          TextButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              setState(() {
                                signIn = !signIn;
                              });
                            },
                            child: (signIn)
                                ? Text('التسجيل')
                                : Text('تسجيل الدخول'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: TextButton(
              onPressed: () => auth.guest(),
              child: Text('اكمل كزائر'),
            ),
          )
        ],
      ),
    );
  }
}
