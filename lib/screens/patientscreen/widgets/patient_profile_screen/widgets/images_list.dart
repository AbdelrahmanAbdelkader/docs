import 'package:flutter/material.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/images_edit_dialog.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    Key? key,
    required this.images,
  }) : super(
          key: key,
        );
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'صور الحالة',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                //هنا التعديل
                showDialog(
                  context: context,
                  builder: (context) => ImagesEditDialog(images: images),
                );
              },
            )
          ],
        ),
        Container(
          width: size.width,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                //color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.black),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
