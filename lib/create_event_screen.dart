import 'package:evently/app_them.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  Category selectedCategory = Category.categories.first;
  TextEditingController titelController = TextEditingController();
  TextEditingController descrplController = TextEditingController();
  DateTime? selectedDate;
  DateFormat dateFormat = DateFormat('dd/M/yyyy');
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Event',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${selectedCategory.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          DefaultTabController(
            length: Category.categories.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.only(left: 6),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              onTap: (index) {
                currentIndex = index;
                selectedCategory = Category.categories[currentIndex];
                setState(() {});
              },
              tabs: Category.categories
                  .map(
                    (category) => TabItem(
                      category: category,
                      isSelected:
                          currentIndex == Category.categories.indexOf(category),
                      selectBackgroundColor: AppThem.primary,
                      selectForegroundColor: AppThem.white,
                      UnselectForegroundColor: AppThem.primary,
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8),
                      DefaultTextFormFiled(
                        hintText: 'Event Title',
                        prefixIcons: 'titel',
                        controller: titelController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Titel can not be empty';
                          }
                          return null;
                        },
                      ),
                      Text(
                        'Description',
                        style: textTheme.bodyLarge,
                      ),
                      DefaultTextFormFiled(
                        hintText: 'Event Description',
                        controller: descrplController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description can not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/date.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Event Date',
                            style: textTheme.bodyLarge,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                                initialDate: selectedDate,
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                              );
                              if (date != null) {
                                selectedDate = date;
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedDate == null
                                  ? 'Choose Date'
                                  : dateFormat.format(selectedDate!),
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: AppThem.primary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/time.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Event Time',
                            style: textTheme.bodyLarge,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (time != null) {
                                selectedTime = time;
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedTime == null
                                  ? 'Choose Time'
                                  : selectedTime!.format(context),
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: AppThem.primary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      DefaultElevatedButton(
                          Lable: 'Add Event', onPressed: createEvent)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime date = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      Event event = Event(
        category: selectedCategory,
        titel: titelController.text,
        description: descrplController.text,
        datetime: date,
      );
      FirebaseService.addEventToFireStore(event);
    }
  }
}
