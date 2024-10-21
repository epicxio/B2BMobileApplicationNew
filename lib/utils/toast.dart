import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomNotifyToast {
  static showCustomToast(BuildContext context, String text) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color.fromRGBO(188, 177, 177, 1))),
      width: 388.w,
      height: 62.h,
      child: Row(
        children: [
          Container(
            width: 14.w,
            height: double.infinity,
            color: const Color.fromRGBO(71, 215, 100, 1),
          ),
          const Icon(
            Icons.check_circle_sharp,
            color: Colors.green,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Success',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => fToast.removeCustomToast(),
                        child: const Icon(
                          Icons.clear,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    text,
                    // 'Approval send to store owner successfully',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.TOP);
  }
}
