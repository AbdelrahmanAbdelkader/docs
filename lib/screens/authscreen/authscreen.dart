import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helper.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/add_patient_text_field.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: authFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Consumer<StateManagment>(
                    builder: (context, stateManagment, _) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                              width: 1, color: Colors.greenAccent),
                        ),
                        elevation: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton(
                            isDense: true,
                            elevation: 0,
                            // focusColor: Colors.white,
                            underline: Container(),
                            value: stateManagment.userDropDownBottonValue,
                            isExpanded: true,
                            hint: const Text('اختر التخصص'),
                            onChanged: (v) => stateManagment
                                .setUserDropDownBottonValue(v as String),
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
                  ElevatedButton(
                      onPressed: () => save(
                            auth,
                            chosenTeam,
                          ),
                      child: (signIn)
                          ? const Text('تسجيل الدخول')
                          : const Text('التسجيل')),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        signIn = !signIn;
                      });
                    },
                    child: (signIn)
                        ? const Text('التسجيل')
                        : const Text('تسجيل الدخول'),
                  ),
                  TextButton(
                    onPressed: () => auth.guest(),
                    child: const Text('اكمل كزائر'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
