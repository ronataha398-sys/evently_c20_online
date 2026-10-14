import 'package:evently/add/event_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_contantes/app_catagory.dart';
import '../tabs/Tabs_widgets.dart';

class Adds extends StatelessWidget {
  Adds({super.key});

  static String routName = "Adds";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return DefaultTabController(
      length: AppCatagory.catagory.length,
      child: ChangeNotifierProvider(
        create: (context) => EventManager(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Add event",
              style: theme.textTheme.titleMedium,
            ),
          ),
          body: Consumer<EventManager>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Center(
                        child: Image.asset(
                          provider.selected.image,
                          height: 164,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Categories
                    TabBar(
                      onTap: (index) {
                        provider.changeIndex(index);
                      },
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: const EdgeInsets.all(8),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: AppCatagory.catagory.asMap().entries.map((entry) {
                        int catagoryIndex = entry.key;
                        var e = entry.value;

                        return TabsWidgets(
                          catagory: e,
                          isSelected: provider.index == catagoryIndex,
                        );
                      }).toList(),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Title",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: provider.titleController,
                        decoration: const InputDecoration(
                          hintText: "Event Title",
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Description",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),

                    SizedBox(
                      height: 168,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: provider.descController,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: "Event Description....",
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Event Date
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/img_6.png",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 4),
                          const Text("Event Date"),
                          const Spacer(),
                          TextButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate:
                                provider.selectedDateTime ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );

                              if (date != null) {
                                provider.changeData(date);
                              }
                            },
                            child: Text(
                              provider.selectedDateTime == null
                                  ? "Choose date"
                                  : DateFormat.yMd()
                                  .format(provider.selectedDateTime!),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Event Time
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/img_8.png",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 4),
                          const Text("Event Time"),
                          const Spacer(),
                          TextButton(
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime:
                                provider.selectedTime ?? TimeOfDay.now(),
                              );

                              if (time != null) {
                                provider.changeTime(time);
                              }
                            },
                            child: Text(
                              provider.selectedTime == null
                                  ? "Choose time"
                                  : provider.selectedTime!.format(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Add Event Button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          elevation: 0,
                          minimumSize: const Size(343, 48),
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () {
                          provider.adds(context);
                        },
                        child: provider.isLoading
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "Add Event",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}