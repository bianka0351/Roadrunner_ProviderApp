import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.number,
      required this.clientName,
      required this.startTime,
      required this.clientAddress,
      required this.status,
      required this.service,
      required this.serviceNumber,
      required this.productNumber,
      required this.clientImage});
  String number;
  String clientName;
  String startTime;
  String clientAddress;
  String status;
  String service;
  int serviceNumber;
  int productNumber;
  String clientImage;
  final Map<String, Color> statusColors = {
    "In Progress": AppColors.inProgressStatusColor,
    "Start": AppColors.startStatusColor,
    "Confirmed": AppColors.tritiaryColor,
    "No Show": AppColors.noShowStatusColor,
    "Finished": AppColors.finishedStatusColor,
    "Arrived": AppColors.arrivedStatusColor,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 86.h,
          width: 387.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Color(0xFFBEC7D0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 35.w,
                height: 86.h,
                decoration: BoxDecoration(
                  color: statusColors[status],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r)),
                ),
                alignment: Alignment.center,
                child: Text(number,
                    style: AppFonts.poppinsSemiBold(
                      color: Colors.white,
                      fontSize: 16.sp,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: (clientImage.isNotEmpty &&
                                  Uri.tryParse(clientImage)?.hasAbsolutePath ==
                                      true)
                              ? NetworkImage(
                                  clientImage,
                                )
                              : null,
                          child: (clientImage.isEmpty ||
                                  Uri.tryParse(clientImage)?.hasAbsolutePath !=
                                      true)
                              ? Icon(Icons.person,
                                  size: 30.sp, color: Colors.white)
                              : null,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(clientName,
                                style: AppFonts.poppinsBold(fontSize: 16.sp)),
                            Text(startTime,
                                style:
                                    AppFonts.poppinsRegular(fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 20.sp, color: AppColors.secondaryColor),
                        SizedBox(width: 5.w),
                        Text(clientAddress,
                            style: AppFonts.poppinsRegular(fontSize: 12.sp)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(status,
                        style: AppFonts.poppinsSemiBold(
                            fontSize: 20.sp, color: statusColors[status])),
                    Text(service,
                        style: AppFonts.poppinsRegular(
                          fontSize: 12.sp,
                          color: AppColors.tritiaryColor,
                        )),
                    Text(
                        "${serviceNumber > 0 ? '$serviceNumber others' : ''}"
                        "${serviceNumber > 0 && productNumber > 0 ? ', ' : ''}"
                        "${productNumber > 0 ? '$productNumber Products' : ''}",
                        style: AppFonts.poppinsRegular(
                          fontSize: 12.sp,
                          color: AppColors.tritiaryColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.tritiaryColor,
                thickness: 1.0,
                indent: 20.w,
              ),
            ),
            Text('18 mil - 0:26 min',
                style: AppFonts.poppinsSemiBold(
                  fontSize: 10.sp,
                  color: AppColors.tritiaryColor,
                )),
            Expanded(
              child: Divider(
                color: AppColors.tritiaryColor,
                thickness: 1.0,
                endIndent: 20.w,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
