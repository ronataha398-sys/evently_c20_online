import 'package:evently/app_contantes/app_catagory.dart';
import 'package:evently/tabs/Tabs_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../tabs/event_widget.dart';
import '../event_modele.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
with SingleTickerProviderStateMixin {
int index = 0;

late TabController tabController;

@override
void initState() {
super.initState();

tabController = TabController(
length: AppCatagory.catagory.length + 1,
vsync: this,
);
}

@override
void dispose() {
tabController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
var user = FirebaseAuth.instance.currentUser;
var theme = Theme.of(context);

return Column(
children: [
// ================= HEADER =================

Row(
children: [
Expanded(
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text("Welcome Back ✨"),
Text(
user?.displayName ?? "",
style: theme.textTheme.titleLarge,
),
],
),
),
),
Image.asset(
"assets/image/img_2.png",
color: theme.primaryColor,
width: 24,
height: 24,
),
const SizedBox(width: 6),
Padding(
padding: const EdgeInsets.all(8.0),
child: Container(
width: 34,
height: 32,
decoration: BoxDecoration(
color: theme.primaryColor,
borderRadius: BorderRadius.circular(8),
),
child: const Center(
child: Text(
"EN",
style: TextStyle(
color: Colors.white,
fontSize: 14,
),
),
),
),
),
],
),

// ================= TABS =================

TabBar(
controller: tabController,
dividerColor: Colors.transparent,
isScrollable: true,
tabAlignment: TabAlignment.start,
padding: const EdgeInsets.all(8),
labelColor: Colors.white,
unselectedLabelColor: Colors.black,
onTap: (value) {
setState(() {
index = value;
});
},
tabs: [
// ALL
TabsWidgets(
catagory: AppCatagory(
name: "All",
id: "All",
image: "",
iconData: Icons.menu,
),
isSelected: index == 0,
),

// CATEGORIES
...AppCatagory.catagory.map((e) {
int categoryIndex =
AppCatagory.catagory.indexOf(e) + 1;

return TabsWidgets(
catagory: e,
isSelected: index == categoryIndex,
);
}).toList(),
],
),

// ================= EVENTS FROM FIREBASE =================

Expanded(
child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
stream: FirebaseFirestore.instance
    .collection('events')
    .snapshots(),

builder: (context, snapshot) {
if (snapshot.hasError) {
return const Center(
child: Text('Something went wrong'),
);
}

if (snapshot.connectionState ==
ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

final documents = snapshot.data?.docs ?? [];

// FILTER BY CATEGORY
final filteredDocuments = index == 0
? documents
    : documents.where((doc) {
final categoryId =
doc.data()['categoryId'] ?? '';

return categoryId ==
AppCatagory.catagory[index - 1].id;
}).toList();

if (filteredDocuments.isEmpty) {
return const Center(
child: Text(
'No events yet. Add your first event!',
),
);
}

return ListView.separated(
padding: const EdgeInsets.all(8),
itemCount: filteredDocuments.length,

itemBuilder: (context, eventIndex) {
final doc = filteredDocuments[eventIndex];
final data = doc.data();

final event = EventModel(
id: doc.id,
categoryId: data['categoryId'] ?? '',
date: data['date'] ?? '',
time: data['time'] ?? '',
title: data['title'] ?? '',
desc: data['desc'] ?? '',
);

return EventWidget(event: event);
},

separatorBuilder: (context, index) {
return const SizedBox(height: 8);
},
);
},
),
),
],
);
}
}
