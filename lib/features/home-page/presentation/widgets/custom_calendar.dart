import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // تنسيق اليوم ليكون بالشكل الذي تريده
  List<DateTime> _getDaysInWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(
        7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final daysInWeek = _getDaysInWeek(_focusedDay);

    return Column(
      children: [
        // شريط التنقل بين الأشهر
        Container(
          height: 40,
          width: 361,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.secondaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      _focusedDay.day,
                    );
                  });
                },
              ),
              Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "PlusJakartaSans",
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      _focusedDay.day,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // التقويم الأسبوعي
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _focusedDay = _focusedDay.subtract(Duration(days: 7));
                });
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: daysInWeek.map((day) {
                  final isSelected =
                      _selectedDay != null && isSameDay(day, _selectedDay!);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: 39,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Text(
                            DateFormat.E()
                                .format(day), // اسم اليوم (Sun, Mon, ...)
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isSelected ? Colors.white : Color(0xff111827),
                              fontWeight: FontWeight.w400,
                              fontFamily: "PlusJakartaSans",
                            ),
                          ),
                          Text(
                            DateFormat.d().format(day), // رقم اليوم (1, 2, ...)
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isSelected ? Colors.white : Color(0xff111827),
                              fontFamily: "PlusJakartaSans",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _focusedDay = _focusedDay.add(Duration(days: 7));
                });
              },
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }

  // مقارنة الأيام لتحديد اليوم المحدد
  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }
}
