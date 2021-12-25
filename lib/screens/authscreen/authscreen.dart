import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen(this.thereAreUsers, {Key? key}) : super(key: key);
  final bool thereAreUsers;

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

  void save(Auth auth, StateManagment team) {
    if (authFormKey.currentState!.validate()) {
      authFormKey.currentState!.save();
      if (team.signIn) {
        auth.signIn();
      } else {
        auth.register(
          userNameController.text,
          userPhoneController.text,
          team.userTeamDropDownBottonValue.toString(),
          team.userSpecialityDropDownBottonValue.toString(),
        );
      }
    }
  }

  bool once = true;
  @override
  Widget build(BuildContext context) {
    final chosenTeam = Provider.of<StateManagment>(context);
    final size = MediaQuery.of(context).size;
    if (once) {
      chosenTeam.roleDropDownBottonValue =
          (thereAreUsers) ? 'master' : 'normal';
      role = (thereAreUsers)
          ? ['master']
          : [
              'normal',
              'caseResponsible',
              'doctorsResposible',
            ];
      once = false;
    }
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
                          if (!chosenTeam.signIn)
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
                          if (!chosenTeam.signIn)
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
                          if (!chosenTeam.signIn)
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
                          if (!chosenTeam.signIn)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Consumer<StateManagment>(
                                      builder: (context, stateManagment, _) =>
                                          Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 1,
                                              color: Colors.greenAccent),
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
                                                .userTeamDropDownBottonValue,
                                            hint: const Text('اختر الفريق'),
                                            onChanged: (v) => stateManagment
                                                .setUserTeamDropDownBottonValue(
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
                                  if (!chosenTeam.signIn)
                                    Expanded(
                                      flex: 1,
                                      child: Consumer<StateManagment>(
                                        builder: (context, stateManagment, _) =>
                                            Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                width: 1,
                                                color: Colors.greenAccent),
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
                                                  .userSpecialityDropDownBottonValue,
                                              hint: const Text('اختر التخصص'),
                                              onChanged: (v) => stateManagment
                                                  .setUserSpecialityDropDownButtonValue(
                                                v as String,
                                              ),
                                              items: List.generate(
                                                speciality.length,
                                                (index) => DropdownMenuItem(
                                                  child: Text(
                                                    speciality[index],
                                                  ),
                                                  value: speciality[index],
                                                ),
                                              ).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (!chosenTeam.signIn)
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
                                          .roleDropDownBottonValue,
                                      isExpanded: true,

                                      onChanged: (v) => stateManagment
                                          .setRoleDropDownBottonValue(
                                              v as String),
                                      items: List.generate(
                                        role.length,
                                        (index) => DropdownMenuItem(
                                          child: Text(
                                            role[index],
                                          ),
                                          value: role[index],
                                        ),
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Consumer<StateManagment>(
                              builder: (context, state, _) {
                                return ElevatedButton(
                                    onPressed: () => save(
                                          auth,
                                          chosenTeam,
                                        ),
                                    child: (state.signIn)
                                        ? const Text('تسجيل الدخول')
                                        : const Text('التسجيل'));
                              },
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              chosenTeam.changeSigning();
                            },
                            child: (chosenTeam.signIn)
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

// if (!chosenTeam.signIn)
//                             Consumer<StateManagment>(
//                               builder: (context, stateManagment, _) => Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     side: const BorderSide(
//                                         width: 1, color: Colors.greenAccent),
//                                   ),
//                                   elevation: 0,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: DropdownButton(
//                                       isDense: true,
//                                       elevation: 50,
//                                       // focusColor: Colors.white,
//                                       underline: Container(),
//                                       value: stateManagment
//                                           .roleDropDownBottonValue,
//                                       isExpanded: true,

//                                       onChanged: (v) => stateManagment
//                                           .setRoleDropDownBottonValue(
//                                               v as String),
//                                       items: List.generate(
//                                         role.length,
//                                         (index) => DropdownMenuItem(
//                                           child: Text(
//                                             role[index],
//                                           ),
//                                           value: role[index],
//                                         ),
//                                       ).toList(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),