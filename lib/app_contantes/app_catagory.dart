import 'package:flutter/material.dart';

class AppCatagory {
String name;
String id;
String image;
IconData iconData;

AppCatagory({
required this.name,
required this.id,
required this.image,
required this.iconData,
});

static List<AppCatagory> catagory = [
AppCatagory(
name: "Sport",
id: "sport",
image: "assets/catogry/img_3.png",
iconData: Icons.sports,
),

AppCatagory(
name: "Birthday",
id: "birthday",
image: "assets/catogry/img_4.png",
iconData: Icons.cake,
),

AppCatagory(
name: "Book Club",
id: "book club",
image: "assets/catogry/img_2.png",
iconData: Icons.book,
),

AppCatagory(
name: "Meeting",
id: "meeting",
image: "assets/catogry/img_5.png",
iconData: Icons.meeting_room,
),
];
}
