import 'package:evently/app_them.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  static const String routeName = '/editEvent';

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  int currentIndex = 0;
  Category selectedCategory = Category.categories.first;
  TextEditingController titelController = TextEditingController();
  TextEditingController descrplController = TextEditingController();
  DateTime? selectedDate;
  DateFormat dateFormat = DateFormat('dd/M/yyyy');
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Event event1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      event1 = ModalRoute.of(context)!.settings.arguments as Event;
      setState(() {
        selectedCategory = event1.category;
        currentIndex = Category.categories.indexOf(selectedCategory);
        titelController = TextEditingController(text: event1.titel);
        descrplController = TextEditingController(text: event1.description);
        selectedDate = event1.datetime;
        selectedTime = TimeOfDay.fromDateTime(event1.datetime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Event',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: ClipRRect(
              key: ValueKey(selectedCategory.imageName),
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
                      lable: category.name,
                      icon: category.icon,
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
                          Lable: 'Update Event', onPressed: createEvent)
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
        id: event1.id,
        UserId:
            Provider.of<UserProvider>(context, listen: false).currenUser!.id,
        category: selectedCategory,
        titel: titelController.text,
        description: descrplController.text,
        datetime: date,
      );
      FirebaseService.updateEventsById(event).then((_) async {
        await Provider.of<EventsProvider>(context, listen: false).getEvents();

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        print(error);
      });
    }
  }
}
