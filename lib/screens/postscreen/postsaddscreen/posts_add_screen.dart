import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

class PostsAddScreen extends StatefulWidget {
  PostsAddScreen({Key? key}) : super(key: key);

  @override
  State<PostsAddScreen> createState() => _PostsAddScreenState();
}

class _PostsAddScreenState extends State<PostsAddScreen> {
  final postsAddFormKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  final voteController = TextEditingController();

  final textKey = Key('gdsagdsgsa');

  final voteKey = Key('voteKey');

  Future<void> save(BuildContext context, String id, String volName) async {
    if (postsAddFormKey.currentState!.validate() && postTypeValue != null ||
        (postsAddFormKey.currentState!.validate() &&
            postTypeValue == 'تصويت' &&
            votes.length < 2)) {
      // postsAddFormKey.currentState!.save();
      final database = FirebaseFirestore.instance;
      final store = FirebaseStorage.instance;
      List<String> imagesId = [];
      files.forEach((element) {
        final fileId = DateTime.now().toString();
        imagesId.add('${id}_$fileId');
        store.ref('posts/${id}_$fileId').putFile(element as File);
      });
      await database.collection('posts').add({
        'votes': (postTypeValue == 'تصويت') ? votes : [],
        'volName': volName,
        'date': DateTime.now().toString(),
        'images': imagesId,
        'type': postTypeValue,
        'title': textController.text,
        'deadLine': DateTime.now().add(Duration(days: 3)).toString(),
      });
      Navigator.pop(context);
    }
  }

  Future pickImage(bool galery) async {
    List? images;

    if (galery)
      images = await ImagePicker().pickMultiImage();
    else
      images = [await ImagePicker().pickImage(source: ImageSource.camera)];
    if (images != null)
      images.forEach((element) {
        if (element != null) files.add(File((element as XFile).path));
      });
    setState(() {});
    print(files);
  }

  List postType = ['عادي', 'هام', 'تصويت'];

  List files = [];
  List votes = [];
  String? postTypeValue;

  @override
  Widget build(BuildContext context) {
    //ناقص هنا تضيف السيف فانكشن
    //و ال statemanagment
    final account = Provider.of<Account>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: postsAddFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 1, color: Colors.greenAccent)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        isExpanded: true,
                        value: postTypeValue,
                        hint: Text('نوع المنشور ؟'),
                        items: postType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        underline: Container(),
                        onChanged: (v) {
                          setState(() {
                            postTypeValue = v as String;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12.0),
                  child: Text(
                    'ادخل المحتوي الكتابي :',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AddPatientTextField(
                    label: 'النص',
                    controller: textController,
                    tKey: textKey,
                    save: (v) {},
                    validate: (String v) {
                      if (v.isEmpty) return 'ادخل النص من فضلك';
                    },
                    multiline: true),
                (postTypeValue != 'تصويت')
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 12.0),
                        child: Text(
                          'اضف صورة ان اردت',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text('اضف تصويت'),
                (postTypeValue != 'تصويت')
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Column(
                                      children: [
                                        Card(
                                          child: IconButton(
                                            onPressed: () async {
                                              await pickImage(true);
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.image),
                                          ),
                                        ),
                                        Card(
                                          child: IconButton(
                                            onPressed: () async {
                                              await pickImage(false);
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.camera),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: (files.isEmpty)
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .5,
                                    vertical: size.height * .1),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 36,
                                ),
                              )
                            : Container(
                                height: size.height * .2,
                                child: GridView.count(
                                    crossAxisCount: 3,
                                    children: files
                                        .map((e) => Image.file(
                                              e,
                                              fit: BoxFit.cover,
                                            ))
                                        .toList()),
                              ),
                      )
                    : Column(
                        children: [
                          ...votes.map(
                            (e) => Container(
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.greenAccent,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    e,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        votes.remove(e);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: AddPatientTextField(
                                    label: 'تصويت',
                                    controller: voteController,
                                    tKey: voteKey,
                                    save: () {},
                                    validate: (v) {
                                      // if ((v as String).isEmpty)
                                      //   return 'ادخل نص من فضلك';
                                    },
                                    multiline: false),
                              ),
                              Expanded(
                                  child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (voteController.text.isNotEmpty) {
                                      votes.add(voteController.text);
                                      voteController.clear();
                                    }
                                  });
                                },
                              ))
                            ],
                          )
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => save(context, account.id as String,
                            account.name as String),
                        child: Text('اضف المنشور'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
