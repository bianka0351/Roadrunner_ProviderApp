import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_app_bar.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_error_message.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/order_detail.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/build_map_section.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_calendar.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final ValueNotifier<bool> _isShowRouteMap = ValueNotifier(false);

  Future<void> _refreshOrders() async {
    final selectedDate = context.read<OrderBloc>().selectedDate;
    context.read<OrderBloc>().add(
          GetOrderListEvent(
            date: DateFormat('yyyy-MM-dd').format(selectedDate),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(text: 'Order List'),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            CustomCalendar(),
            SizedBox(height: 10.h),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshOrders,
                color: AppColors.tritiaryColor,
                displacement: 50.0,
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      BotToast.showLoading(clickClose: false);
                      return SizedBox();
                    } else if (state is OrderSuccess) {
                      BotToast.closeAllLoading();
                      if (state.orderList!.orders == null ||
                          state.orderList!.orders!.isEmpty) {
                        return ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 300.h),
                                child: Text(
                                  "No orders scheduled for this day.",
                                  style: AppFonts.poppinsBold(
                                      fontSize: 18.sp,
                                      color: AppColors.tritiaryColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      state.orderList!.orders!.sort((a, b) {
                        DateTime startA =
                            DateFormat("hh:mm a").parse(a.startTime!);
                        DateTime startB =
                            DateFormat("hh:mm a").parse(b.startTime!);
                        return startA.compareTo(startB);
                      });
                      return Column(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: _isShowRouteMap,
                            builder: (context, isShowRouteMap, child) {
                              return Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _isShowRouteMap.value =
                                          !_isShowRouteMap.value;
                                    },
                                    child: Text(
                                      isShowRouteMap ? "Hide Map" : "Show Map",
                                      style: AppFonts.poppinsRegular(
                                        fontSize: 16.sp,
                                        color: isShowRouteMap
                                            ? AppColors.tritiaryColor
                                            : AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (isShowRouteMap) BuildMapSection()
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.orderList!.orders!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OrderDetail();
                                    }));
                                  },
                                  child: CustomCard(
                                    number: "${index + 1}",
                                    clientName:
                                        "${state.orderList!.orders![index].clientName}",
                                    startTime:
                                        "${state.orderList!.orders![index].startTime}",
                                    clientAddress:
                                        "${state.orderList!.orders![index].clientAddress}",
                                    productNumber: state.orderList!
                                        .orders![index].orderProducts!.length,
                                    status:
                                        "${state.orderList!.orders![index].status}",
                                    service: state.orderList!.orders![index]
                                        .orderServices![0],
                                    serviceNumber: state
                                            .orderList!
                                            .orders![index]
                                            .orderServices!
                                            .length -
                                        1,
                                    clientImage:
                                        "${state.orderList!.orders![index].clientImage}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is OrderFailure) {
                      BotToast.closeAllLoading();
                      CustomErrorMessage().showCustomMessage(
                          message: state.message,
                          icon: Icons.warning_amber_rounded);
                      return SizedBox();
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 40.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
