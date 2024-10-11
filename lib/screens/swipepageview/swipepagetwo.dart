import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 150.h,
          ),
          child: const Image(image: AssetImage("assets/images/image8.png")),
        ),
        FittedBox(
          alignment: Alignment.center,
          child: Text(
            'Welcome to Coswan Silvers',
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: true,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
            ),
          ),
        ),
        SizedBox(
          height: 17.h,
        ),
        FittedBox(
          alignment: Alignment.center,
          child: Container(
            width: 307.w,
            height: 54.h,
            alignment: Alignment.center,
            child: FittedBox(
              alignment: Alignment.center,
              child: RichText(
                  text: TextSpan(
                      text: 'Connect Buyers and Suppliers of the',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(51, 51, 51, 1),
                      ),
                      
                      children: [
                    TextSpan(
                      text: '\nSilvers',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: " Jewellery Industry",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(51, 51, 51, 1),
                      ),
                    )
                  ])),
            ),
          
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
          
            //    // Text(
            //     //   'Connect Buyers and Suppliers of the',
          
            //     // ),
            //     // Row(
            //     //   mainAxisAlignment: MainAxisAlignment.center,
            //     //   children: [
          
            //     //   ],
            //     // )
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}
