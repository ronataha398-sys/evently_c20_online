import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../app_contantes/app_catagory.dart';
import '../event_modele.dart';

class EditEvent extends StatefulWidget {
final EventModel event;

const EditEvent({
super.key,
required this.event,
});

@override
State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
late final TextEditingController titleController;
late final TextEditingController descController;

late String selectedCategory;
late DateTime selectedDate;
late TimeOfDay selectedTime;

bool isSaving = false;

@override
late var theme=Theme.of(context);
void initState() {
super.initState();

titleController = TextEditingController(
text: widget.event.title,
);

descController = TextEditingController(
text: widget.event.desc,
);

selectedCategory = AppCatagory.catagory.any(
(item) => item.id == widget.event.categoryId,
)
? widget.event.categoryId
    : AppCatagory.catagory.first.id;

selectedDate =
DateTime.tryParse(widget.event.date) ?? DateTime.now();

selectedTime = _parseTime(widget.event.time);
}

TimeOfDay _parseTime(String value) {
try {
final parts = value.split(':');
var hour = int.parse(parts[0]);
final minute = int.parse(parts[1].split(' ')[0]);

if (value.toLowerCase().contains('pm') && hour < 12) {
hour += 12;
} else if (value.toLowerCase().contains('am') && hour == 12) {
hour = 0;
}

return TimeOfDay(hour: hour, minute: minute);
} catch (_) {
return TimeOfDay.now();
}
}

Future<void> chooseDate() async {
final date = await showDatePicker(
context: context,
initialDate: selectedDate,
firstDate: DateTime(2000),
lastDate: DateTime(2100),
);

if (date != null) {
setState(() {
selectedDate = date;
});
}
}

Future<void> chooseTime() async {
final time = await showTimePicker(
context: context,
initialTime: selectedTime,
);

if (time != null) {
setState(() {
selectedTime = time;
});
}
}

Future<void> saveChanges() async {
if (titleController.text.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Enter event title')),
);
return;
}

setState(() => isSaving = true);

try {
final formattedDate =
'${selectedDate.year.toString().padLeft(4, '0')}-'
'${selectedDate.month.toString().padLeft(2, '0')}-'
'${selectedDate.day.toString().padLeft(2, '0')}';

final formattedTime = selectedTime.format(context);

await FirebaseFirestore.instance
    .collection('events')
    .doc(widget.event.id)
    .update({
'title': titleController.text.trim(),
'desc': descController.text.trim(),
'categoryId': selectedCategory,
'date': formattedDate,
'time': formattedTime,
});

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Event updated successfully')),
);

Navigator.pop(context, true);
} catch (e) {
if (mounted) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Update failed: $e')),
);
}
} finally {
if (mounted) {
setState(() => isSaving = false);
}
}
}

@override
void dispose() {
titleController.dispose();
descController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Edit Event'),
centerTitle: true,
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
TextField(
controller: titleController,
decoration: const InputDecoration(
labelText: 'Event Title',
border: OutlineInputBorder(),
),
),
const SizedBox(height: 16),
TextField(
controller: descController,
maxLines: 4,
decoration: const InputDecoration(
labelText: 'Description',
border: OutlineInputBorder(),
),
),
const SizedBox(height: 16),
DropdownButtonFormField<String>(
value: selectedCategory,
decoration: const InputDecoration(
labelText: 'Category',
border: OutlineInputBorder(),
),
items: AppCatagory.catagory.map((category) {
return DropdownMenuItem<String>(
value: category.id,
child: Text(category.name),
);
}).toList(),
onChanged: (value) {
if (value != null) {
setState(() => selectedCategory = value);
}
},
),
const SizedBox(height: 16),
OutlinedButton.icon(
onPressed: chooseDate,
icon: const Icon(Icons.calendar_month),
label: Text(
'Date: ${selectedDate.year}-'
'${selectedDate.month.toString().padLeft(2, '0')}-'
'${selectedDate.day.toString().padLeft(2, '0')}',
),
),
const SizedBox(height: 12),
OutlinedButton.icon(
onPressed: chooseTime,
icon: const Icon(Icons.access_time),
label: Text(
'Time: ${selectedTime.format(context)}',
),
),
const SizedBox(height: 24),
ElevatedButton(
onPressed: isSaving ? null : saveChanges,
child: isSaving
? const CircularProgressIndicator()
    :  Text('Save Changes',style: TextStyle(
  color: Colors.white
) ,),
),
],
),
),
);
}
}
