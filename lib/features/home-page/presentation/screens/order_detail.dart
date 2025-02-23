import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_button.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_error_message.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_map.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_client_detail.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_payment_summary.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_small_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key, required this.id});
  final int? id;
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final ValueNotifier<bool> _isShowRouteMap = ValueNotifier(false);
  @override
  void dispose() {
    _isShowRouteMap.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Order Detail',
            style: AppFonts.poppinsSemiBold(fontSize: 32.sp)),
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 15.w),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35.sp,
          ),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderDetailSuccess) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomMap(),
                        SizedBox(height: 15.h),
                        CustomClientDetail(
                          clientName: "${state.details?.clientName}",
                          time: "${state.details?.startTime}",
                          durationTime: "${state.details?.durationTime}",
                          location: [
                            state.details?.clientAddress!.streetAddress,
                            state.details?.clientAddress!.city,
                            state.details?.clientAddress!.state,
                          ].join(", "),
                          phoneNumber: "${state.details?.phoneNumber}",
                          status: "${state.details?.status}",
                          clientImage: "${state.details?.clientImage}",
                        ),
                        SizedBox(height: 15.h),
                        CustomPaymentSummary(),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomSmallButton(
                                icon: Icons.chat_outlined,
                                text: 'CHAT',
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.cancel,
                                    color: AppColors.noShowStatusColor,
                                    size: 50.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(text: 'START', onpressed: () {}),
                SizedBox(height: 30.h),
              ],
            );
          } else if (state is OrderFailure) {
            CustomErrorMessage().showCustomMessage(
                message: state.message, icon: Icons.warning_amber_rounded);
            return SizedBox();
          }
          return SizedBox();
        },
      ),
    );
  }
}
