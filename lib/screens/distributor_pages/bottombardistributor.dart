import 'package:coswan/screens/distributor_pages/orderstatustabbar.dart';
import 'package:coswan/screens/distributor_pages/vendorspage.dart';
import 'package:coswan/screens/notifiactionview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarDistributor extends StatefulWidget {
  const BottomBarDistributor({super.key});

  @override
  State<BottomBarDistributor> createState() => _BottomBarDistributorState();
}

class _BottomBarDistributorState extends State<BottomBarDistributor> {
  @override
  Widget build(BuildContext context) {
    const placeholderitem = Opacity(
      
      opacity: 0,
      child: Icon(Icons.no_cell, size: 35,),
    );
    return BottomAppBar(
      elevation: 0,
      height: 87.h,
      // clipBehavior: Clip.none,
      color: Theme.of(context).primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const VendorsPage())));
            },
            child: bottombarItems(
                SvgPicture.asset("assets/icons/ic_bottomBarVendor.svg"), "Vendors"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationView()));
            },
            child: bottombarItems(
                SvgPicture.asset("assets/icons/ic_bottomBarNotifications.svg"), 'Notifications'),
          ),
          placeholderitem,
          bottombarItems(SvgPicture.asset("assets/icons/ic_bottomBarChat.svg"), 'Chat'),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderStatusTabBar()));
            },
            child: bottombarItems(
                SvgPicture.asset("assets/icons/ic_bottomBarOrder.svg"), 'Orders'),
          ),
        ],
      ),
    );
  }

  Widget bottombarItems(SvgPicture icon, String label) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(width: 44.w, height: 39.h, child: icon),
          Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
