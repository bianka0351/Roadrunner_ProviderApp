import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _selectedDay = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderBloc>().add(GetOrderListEvent(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
    });
  }

  List<DateTime> _getDaysInWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(
        7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  DateTime _getDisplayMonth() {
    return DateTime(_focusedDay.value.year, _focusedDay.value.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, child) {
            return Container(
              height: 40.h,
              width: 361.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 18.sp),
                    onPressed: () {
                      _focusedDay.value =
                          DateTime(value.year, value.month - 1, 1);
                    },
                  ),
                  Text(
                    DateFormat.yMMMM().format(_getDisplayMonth()),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 18.sp),
                    onPressed: () {
                      _focusedDay.value =
                          DateTime(value.year, value.month + 1, 1);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, child) {
            final daysInWeek = _getDaysInWeek(value);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Colors.black, size: 18.sp),
                  onPressed: () {
                    _focusedDay.value =
                        _focusedDay.value.subtract(Duration(days: 7));
                  },
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: daysInWeek.map((day) {
                      final isSelected = isSameDay(day, _selectedDay.value);
                      final isToday = isSameDay(day, DateTime.now());
                      return ValueListenableBuilder<DateTime>(
                        valueListenable: _selectedDay,
                        builder: (context, selectedValue, child) {
                          return GestureDetector(
                            onTap: () {
                              _selectedDay.value = day;
                              _focusedDay.value = day;
                              context.read<OrderBloc>().selectedDate =
                                  _selectedDay.value;
                              context.read<OrderBloc>().add(
                                    GetOrderListEvent(
                                        date: DateFormat('yyyy-MM-dd')
                                            .format(_selectedDay.value)),
                                  );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              width: 39.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.E().format(day),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: isToday && isSelected
                                          ? Colors.white
                                          : (isSelected
                                              ? Colors.white
                                              : (isToday
                                                  ? AppColors.primaryColor
                                                  : const Color(0xff111827))),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PlusJakartaSans",
                                    ),
                                  ),
                                  Text(
                                    DateFormat.d().format(day),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: isToday && isSelected
                                          ? Colors.white
                                          : (isSelected
                                              ? Colors.white
                                              : (isToday
                                                  ? AppColors.primaryColor
                                                  : const Color(0xff111827))),
                                      fontFamily: "PlusJakartaSans",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 18.sp),
                  onPressed: () {
                    _focusedDay.value =
                        _focusedDay.value.add(Duration(days: 7));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }
}
