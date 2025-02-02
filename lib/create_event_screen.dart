import 'package:evently/app_them.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/provider/events_provider.dart';
import 'package:evently/provider/setting_provider_them.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations app_localizations = AppLocalizations.of(context)!;

    TextTheme textTheme = Theme.of(context).textTheme;
    bool isdark =
        Provider.of<SettingProviderThem>(context, listen: false).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          app_localizations.create_event,
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
                        app_localizations.title,
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8),
                      DefaultTextFormFiled(
                        hintText: app_localizations.event_title,
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
                        app_localizations.description,
                        style: textTheme.bodyLarge,
                      ),
                      DefaultTextFormFiled(
                        hintText: app_localizations.description,
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
                            color: isdark ? AppThem.white : AppThem.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            app_localizations.event_date,
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
                            color: isdark ? AppThem.white : AppThem.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            app_localizations.event_time,
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
                          Lable: app_localizations.add_event,
                          onPressed: createEvent)
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
        UserId:
            Provider.of<UserProvider>(context, listen: false).currenUser!.id,
        titel: titelController.text,
        description: descrplController.text,
        datetime: date,
      );
      FirebaseService.addEventToFireStore(event).then((_) {
        Provider.of<EventsProvider>(context, listen: false).getEvents();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Event Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppThem.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).catchError((_) {
        Fluttertoast.showToast(
          msg: "Failed to create event",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppThem.red,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      });
    }
  }
}
