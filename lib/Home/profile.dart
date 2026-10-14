import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../event_modele.dart';
import '../tabs/event_widget.dart';

class Profile extends StatelessWidget {
const Profile({super.key});

@override
Widget build(BuildContext context) {
final user = FirebaseAuth.instance.currentUser;

if (user == null) {
return const Center(
child: Text('Please login to see your favorites'),
);
}

final favoritesStream = FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favorites')
    .snapshots();

return Scaffold(
appBar: AppBar(
title: const Text('Profile'),
centerTitle: true,
),
body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
stream: favoritesStream,
builder: (context, snapshot) {
if (snapshot.hasError) {
return const Center(
child: Text('Something went wrong'),
);
}

if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

final docs = snapshot.data?.docs ?? [];

if (docs.isEmpty) {
return const Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Icon(
Icons.favorite_border,
size: 70,
color: Colors.grey,
),
SizedBox(height: 12),
Text('No favorite events yet'),
],
),
);
}

return ListView.separated(
padding: const EdgeInsets.all(16),
itemCount: docs.length,
separatorBuilder: (_, __) =>
const SizedBox(height: 12),
itemBuilder: (context, index) {
final data = docs[index].data();

final event = EventModel(
id: data['id'] ?? docs[index].id,
categoryId: data['categoryId'] ?? '',
date: data['date'] ?? '',
time: data['time'] ?? '',
title: data['title'] ?? '',
desc: data['desc'] ?? '',
);

return EventWidget(event: event);
},
);
},
),
);
}
}
