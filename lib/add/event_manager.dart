import 'package:evently/app_contantes/app_catagory.dart';
import 'package:evently/core/db_services.dart';
import 'package:evently/event_modele.dart';
import 'package:flutter/material.dart';

class EventManager extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;

  int index = 0;
  AppCatagory selected = AppCatagory.catagory.first;

  void changeIndex(int value) {
    index = value;
    selected = AppCatagory.catagory[index];
    notifyListeners();
  }

  void changeData(DateTime data) {
    selectedDateTime = data;
    notifyListeners();
  }

  void changeTime(TimeOfDay day) {
    selectedTime = day;
    notifyListeners();
  }

  bool isLoading = false;

  void adds(BuildContext context) async {
    isLoading = true;
    notifyListeners();

      await DbServices.adds(
        EventModel(
          id: "",
          categoryId: selected.id,
          date: selectedDateTime.toString(),
          desc: descController.text,
          time: selectedTime!.format(context),
          title: titleController.text,
        ),
      );
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    }
  }