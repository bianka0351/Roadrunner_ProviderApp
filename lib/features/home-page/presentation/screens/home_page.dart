import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_app_bar.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_error_message.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_response_model.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/order_detail.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_map.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_calendar.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> routeDetails = [];

//A function to refresh the page to fetch new requests.
  Future<void> _refreshOrders() async {
    final selectedDate = context.read<OrderBloc>().selectedDate;
    context.read<OrderBloc>().add(
          GetOrderListEvent(
            date: DateFormat('yyyy-MM-dd').format(selectedDate),
          ),
        );
  }

//A function to add the addresses of all orders with the selected date to a list.
  List<String> getOrderAddress(List<Order> orders) {
    List<String> locations = [];
    for (Order order in orders) {
      String address = [
        order.clientAddress!.streetAddress,
        order.clientAddress!.city,
        "${order.clientAddress!.state} ${order.clientAddress!.zipCode}",
        order.clientAddress!.country
      ].join(", ");
      locations.add(address);
    }
    return locations;
  }

  Future<void> cacheOrderList(List<Order> orders) async {
    var box = Hive.box('orderCache');
    await box.put('lastOrderList', orders.map((e) => e.toJson()).toList());
  }

//Update routeDetails upon receiving data from the map.
  void handleRouteDetailsUpdate(List<Map<String, dynamic>> details) {
    setState(() {
      routeDetails = details;
    });
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
                                      color: AppColors.tritiaryColor),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      //Sort orders by time
                      state.orderList!.sort((a, b) {
                        DateTime startA =
                            DateFormat("hh:mm a").parse(a.startTime!);
                        DateTime startB =
                            DateFormat("hh:mm a").parse(b.startTime!);
                        return startA.compareTo(startB);
                      });

                      // Save orders in cache storage
                      cacheOrderList(state.orderList!);

                      return Column(
                        children: [
                          CustomMap(
                            locations: getOrderAddress(state.orderList!),
                            onRouteDetailsUpdated: handleRouteDetailsUpdate,
                          ),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.orderList!.length,
                              itemBuilder: (context, index) {
                                final order = state.orderList![index];

                                // Fetch distance and duration from routeDetails
                                String distance = '';
                                String duration = '';
                                if (routeDetails.isNotEmpty &&
                                    index < routeDetails.length) {
                                  distance =
                                      routeDetails[index]['distance'] ?? '';
                                  duration =
                                      routeDetails[index]['duration'] ?? '';
                                }

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
                                    clientName: "${order.clientName}",
                                    startTime: "${order.startTime}",
                                    clientAddress: [
                                      order.clientAddress!.streetAddress,
                                      order.clientAddress!.city,
                                      order.clientAddress!.state,
                                    ].join(", "),
                                    productNumber: order.orderProducts!.length,
                                    status: "${order.status}",
                                    service:
                                        "${order.orderServices![0].serviceName}",
                                    serviceNumber:
                                        order.orderServices!.length - 1,
                                    clientImage: "${order.clientImage}",
                                    isLastOrder:
                                        index == state.orderList!.length - 1,
                                    distance: distance,
                                    duration: duration,
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
