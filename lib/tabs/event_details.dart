import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_contantes/app_catagory.dart';
import '../event_modele.dart';
import 'editevent.dart';

class EventDetails extends StatelessWidget {
final EventModel event;

const EventDetails({
super.key,
required this.event,
});

static const String routName = "EventDetails";

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

final category = AppCatagory.catagory.firstWhere(
(element) => element.id == event.categoryId,
orElse: () => AppCatagory.catagory.first,
);

final eventDate = DateTime.tryParse(event.date);

return Scaffold(
appBar: AppBar(
title: const Text("Event Details"),
centerTitle: true,
actions: [
IconButton(
tooltip: 'Edit Event',
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => EditEvent(event: event),
),
);
},
icon: const Icon(Icons.edit_outlined),
),
IconButton(
tooltip: 'Delete Event',
onPressed: () async {
if (event.id.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Event ID is missing"),
),
);
return;
}

final confirm = await showDialog<bool>(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text("Delete Event"),
content: const Text(
"Are you sure you want to delete this event?",
),
actions: [
TextButton(
onPressed: () =>
Navigator.pop(dialogContext, false),
child: const Text("Cancel"),
),
TextButton(
onPressed: () =>
Navigator.pop(dialogContext, true),
child: const Text("Delete"),
),
],
),
);

if (confirm != true || !context.mounted) return;

try {
await FirebaseFirestore.instance
    .collection("events")
    .doc(event.id)
    .delete();

if (context.mounted) {
Navigator.pop(context);
}
} catch (e) {
if (context.mounted) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Delete failed: $e")),
);
}
}
},
icon: const Icon(Icons.delete_outline),
),
],
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
ClipRRect(
borderRadius: BorderRadius.circular(16),
child: Container(
width: double.infinity,
height: 220,
color: Colors.white,
child: Image.asset(
category.image,
fit: BoxFit.contain,
),
),
),
const SizedBox(height: 20),
Text(
event.title,
style: theme.textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 16),
Row(
children: [
Icon(
Icons.calendar_month,
color: theme.primaryColor,
size: 28,
),
const SizedBox(width: 12),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
"Event Date",
style: TextStyle(fontWeight: FontWeight.bold),
),
Text(
eventDate == null
? event.date
    : DateFormat.yMMMMd().format(eventDate),
),
],
),
],
),
const SizedBox(height: 16),
Row(
children: [
Icon(
Icons.access_time,
color: theme.primaryColor,
size: 28,
),
const SizedBox(width: 12),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
"Event Time",
style: TextStyle(fontWeight: FontWeight.bold),
),
Text(event.time),
],
),
],
),
const SizedBox(height: 24),
const Text(
"Description",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
event.desc.isEmpty
? "No description available"
    : event.desc,
style: theme.textTheme.bodyLarge,
),
],
),
),
);
}
}
