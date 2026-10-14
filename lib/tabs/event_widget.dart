import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../event_modele.dart';
import '../app_contantes/app_catagory.dart';
import 'event_details.dart';

class EventWidget extends StatelessWidget {
final EventModel event;

const EventWidget({
super.key,
required this.event,
});

Future<void> toggleFavorite() async {
final user = FirebaseAuth.instance.currentUser;

if (user == null) {
throw Exception('Please login first');
}

final favoriteRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favorites')
    .doc(event.id);

final favorite = await favoriteRef.get();

if (favorite.exists) {
await favoriteRef.delete();
} else {
await favoriteRef.set(event.toJson());
}
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
final user = FirebaseAuth.instance.currentUser;

final category = AppCatagory.catagory.firstWhere(
(item) => item.id == event.categoryId,
orElse: () => AppCatagory.catagory.first,
);

final eventDate = event.date.split(' ').first;

final formattedDate = eventDate.contains('-')
? eventDate.split('-').reversed.join('/')
    : eventDate;

final favoriteRef = user == null
? null
    : FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favorites')
    .doc(event.id);

return InkWell(
borderRadius: BorderRadius.circular(16),
onTap: () {
Navigator.pushNamed(
context,
EventDetails.routName,
arguments: event,
);
},
child: Container(
height: 180,
width: double.infinity,
clipBehavior: Clip.antiAlias,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(16),
border: Border.all(
color: Colors.grey.withOpacity(0.15),
),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.08),
blurRadius: 8,
offset: const Offset(0, 3),
),
],
),
child: Column(
children: [
Expanded(
child: Stack(
children: [
Positioned.fill(
child: Container(
color: Colors.transparent,
padding: const EdgeInsets.all(8),
child: Image.asset(
category.image,
fit: BoxFit.contain,
alignment: Alignment.center,
),
),
),

Positioned(
top: 8,
left: 8,
child: Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 7,
),
decoration: BoxDecoration(
color: Colors.transparent,
borderRadius: BorderRadius.circular(8),
),
child: Text(
formattedDate,
style: const TextStyle(
color: Color(0xFF1846A3),
fontSize: 14,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
),

Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 4,
),
color: Colors.transparent,
child: Row(
children: [
Expanded(
child: Text(
event.title,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: Color(0xFF1846A3),
fontSize: 16,
fontWeight: FontWeight.w600,
),
),
),

if (favoriteRef != null)
StreamBuilder<
DocumentSnapshot<Map<String, dynamic>>>(
stream: favoriteRef.snapshots(),
builder: (context, snapshot) {
final isFavorite =
snapshot.data?.exists ?? false;

return IconButton(
visualDensity: VisualDensity.compact,
onPressed: () async {
try {
await toggleFavorite();
} catch (e) {
if (context.mounted) {
ScaffoldMessenger.of(context)
    .showSnackBar(
const SnackBar(
content: Text(
'Could not update favorites',
),
),
);
}
}
},
icon: Icon(
isFavorite
? Icons.favorite
    : Icons.favorite_border,
color: isFavorite
? Colors.blue
    : const Color(0xFF2196F3),
size: 26,
),
);
},
)
else
const Icon(
Icons.favorite_border,
color: Color(0xFF2196F3),
size: 26,
),
],
),
),
],
),
),
);
}
}
