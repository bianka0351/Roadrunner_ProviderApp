import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(text: 'Order List'),
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomCalendar(),
              ValueListenableBuilder<bool>(
                valueListenable: _isShowRouteMap,
                builder: (context, isShowRouteMap, child) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _isShowRouteMap.value = !_isShowRouteMap.value;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isShowRouteMap
                                ? AppColors.tritiaryColor
                                : AppColors.primaryColor,
                            fixedSize: Size(224.w, 38.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                        child: Text(
                          isShowRouteMap ? "Hide Map" : "Show Map",
                          style: AppFonts.poppinsBold(
                              fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (isShowRouteMap) BuildMapSection()
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                  if (state is OrderLoading) {
                    BotToast.showLoading(clickClose: false);
                  } else if (state is OrderSuccess) {
                    BotToast.closeAllLoading();
                    if (state.orderList!.orders == null ||
                        state.orderList!.orders!.isEmpty) {
                      return Center(
                        child: Text(
                          "No orders scheduled for this day.",
                          style: AppFonts.poppinsBold(
                              fontSize: 18.sp, color: AppColors.tritiaryColor),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return OrderDetail();
                        }));
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.orderList!.orders!.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                              number: "${index + 1}",
                              clientName:
                                  "${state.orderList!.orders![index].clientName}",
                              startTime:
                                  "${state.orderList!.orders![index].startTime}",
                              clientAddress:
                                  "${state.orderList!.orders![index].clientAddress}",
                              productNumber: state.orderList!.orders![index]
                                  .orderProducts!.length,
                              status:
                                  "${state.orderList!.orders![index].status}",
                              service: state
                                  .orderList!.orders![index].orderServices![0],
                              serviceNumber: state.orderList!.orders![index]
                                      .orderServices!.length -
                                  1,
                              clientImage:
                                  "${state.orderList!.orders![index].clientImage}",
                            );
                          }),
                    );
                  } else if (state is OrderFailure) {
                    BotToast.closeAllLoading();
                    CustomErrorMessage().showCustomMessage(
                        message: state.message,
                        icon: Icons.warning_amber_rounded);
                  }
                  return SizedBox();
                }),
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
      ),
    );
  }
}
