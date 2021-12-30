import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen(this.thereAreUsers, {Key? key}) : super(key: key);
  final bool thereAreUsers;

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

  bool triedToValidate = false;
  void save(
    Auth auth,
    // StateManagment teamTrue,
    // StateManagment teamFalse,
  ) {
    auth.toggleTriedToValidate();
    if (authFormKey.currentState!.validate()) {
      authFormKey.currentState!.save();
      if (auth.signIn) {
        auth.signInFun(emailController.text, passwordController.text);
      } else if (!auth.signIn &&
          auth.userTeamDropDownBottonValue != null &&
          auth.roleDropDownBottonValue != null) {
        auth.register(
            email: emailController.text,
            password: passwordController.text,
            thereAreUsers: thereAreUsers,
            userName: userNameController.text,
            userPhone: userPhoneController.text);
      }
    }
  }

  bool once = true;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final size = MediaQuery.of(context).size;
    if (once) {
      role = (!thereAreUsers)
          ? ['متطوع غني']
          : [
              'متطوع غني',
              'متطوع فقير',
              'مسؤول أبحاث',
              'مسؤول دكاترة',
            ];
      once = false;
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Container(
                  width: size.width,
                  child: Image.asset(
                    'assets/background.png',
                    fit: BoxFit.fill,
                  ))),
          SizedBox(
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
                        if (!auth.signIn)
                          AddPatientTextField(
                              label: 'اسم المستخدم',
                              controller: userNameController,
                              tKey: userNameKey,
                              textInputAction: TextInputAction.next,
                              save: (v) {},
                              validate: (v) {
                                if (v.length < 2) {
                                  return 'ادخل اسم مستخدم صحيح';
                                }
                              },
                              multiline: false),
                        AddPatientTextField(
                          label: 'الايميل',
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          tKey: emailKey,
                          multiline: false,
                          save: (v) {},
                          validate: (String v) {
                            if (!v.endsWith('.com') && !v.contains('@')) {
                              return 'ادخل ايميل صحيح';
                            }
                          },
                        ),
                        if (!auth.signIn)
                          Consumer<Auth>(
                            builder: (context, stateManagment, _) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    isDense: true,
                                    elevation: 50,
                                    // focusColor: Colors.white,
                                    underline: Container(),
                                    hint: Text('اختر المركز'),
                                    value:
                                        stateManagment.stateDropDownBottonValue,
                                    isExpanded: true,

                                    onChanged: (v) {
                                      stateManagment
                                          .setstateDropDownBottonValue(
                                              v as String);
                                    },
                                    items: List.generate(
                                      states.length,
                                      (index) => DropdownMenuItem(
                                        child: Text(
                                          states[index],
                                        ),
                                        value: states[index],
                                      ),
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        AddPatientTextField(
                          textInputAction: TextInputAction.next,
                          invisible: true,
                          label: 'كلمة السر',
                          controller: passwordController,
                          tKey: passwordKey,
                          multiline: false,
                          save: (v) {},
                          validate: (v) {
                            if (v.length < 8) {
                              return 'ادخل علي الاقل 8 حروف او ارقام';
                            }
                          },
                        ),
                        if (!auth.signIn)
                          AddPatientTextField(
                            textInputAction: TextInputAction.next,
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
                        if (!auth.signIn)
                          AddPatientTextField(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
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
                        if (!auth.signIn)
                          Column(
                            children: [
                              Consumer<Auth>(
                                builder: (context, stateManagment, _) =>
                                    Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          width: 1, color: Colors.greenAccent),
                                    ),
                                    elevation: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        elevation: 50,
                                        // focusColor: Colors.white,
                                        underline: Container(),
                                        value: auth.roleDropDownBottonValue,
                                        isExpanded: true,

                                        onChanged: (v) =>
                                            auth.setRoleDropDownBottonValue(
                                                v as String),
                                        hint: Text('مهمتك في الفريق'),
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
                              if (auth.triedToValidate &&
                                  auth.roleDropDownBottonValue == null)
                                Text(
                                  'اختر مهمتك في الفريق',
                                  style: TextStyle(color: Colors.red),
                                )
                            ],
                          ),
                        if (!auth.signIn)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Consumer<Auth>(
                                            builder:
                                                (context, stateManagment, _) =>
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButton(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  isExpanded: true,
                                                  elevation: 50,
                                                  // focusColor: Colors.white,
                                                  underline: Container(),
                                                  value: stateManagment
                                                      .userTeamDropDownBottonValue,
                                                  hint:
                                                      const Text('اختر الفريق'),
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: (auth.triedToValidate &&
                                                auth.userTeamDropDownBottonValue ==
                                                    null)
                                            ? Text(
                                                'اختر الفريق',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Consumer<Auth>(
                            builder: (context, state, _) {
                              return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    save(
                                      auth,
                                    );
                                  },
                                  child: (auth.signIn)
                                      ? const Text('تسجيل الدخول')
                                      : const Text('التسجيل'));
                            },
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 255, 255, 0))),
                          onPressed: () {
                            auth.changeSigning();
                          },
                          child: (auth.signIn)
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
          Positioned(
            top: 0,
            left: 0,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(255, 255, 255, 0),
                ),
              ),
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