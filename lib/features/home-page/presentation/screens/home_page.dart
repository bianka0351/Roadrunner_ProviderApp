import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_app_bar.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_error_message.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/order_detail.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_map.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_calendar.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                color: AppColors.tertiaryColor,
                displacement: 50.0,
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is OrderSuccess) {
                      if (state.orderList?.isEmpty ?? true) {
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
                                      color: AppColors.tertiaryColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      state.orderList!.sort((a, b) {
                        DateTime startA =
                            DateFormat("hh:mm a").parse(a.startTime!);
                        DateTime startB =
                            DateFormat("hh:mm a").parse(b.startTime!);
                        return startA.compareTo(startB);
                      });
                      return Column(
                        children: [
                          CustomMap(),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.orderList!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<OrderBloc>(context).add(
                                        GetOrderDetailEvent(
                                            clientId: state.orderList![index]
                                                    .clientId ??
                                                0));
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OrderDetail(
                                        id: state.orderList![index].clientId,
                                      );
                                    }));
                                  },
                                  child: CustomCard(
                                    number: "${index + 1}",
                                    clientName:
                                        "${state.orderList![index].clientName}",
                                    startTime:
                                        "${state.orderList![index].startTime}",
                                    clientAddress: [
                                      state.orderList![index].clientAddress!
                                          .streetAddress,
                                      state.orderList![index].clientAddress!
                                          .city,
                                      state.orderList![index].clientAddress!
                                          .state,
                                    ].join(", "),
                                    productNumber: state.orderList![index]
                                        .orderProducts!.length,
                                    status: "${state.orderList![index].status}",
                                    service:
                                        "${state.orderList![index].orderServices![0].serviceName}",
                                    serviceNumber: state.orderList![index]
                                            .orderServices!.length -
                                        1,
                                    clientImage:
                                        "${state.orderList![index].clientImage}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is OrderFailure) {
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
