import 'package:coswan/screens/whislist.dart';
import 'package:coswan/screens/cartpage.dart';
import 'package:coswan/screens/shorts_video_page.dart';
import 'package:coswan/services/cart_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBarWidgetpage extends StatefulWidget {
  final int index;
  final ValueChanged<int> onTapChanged;
  const BottomBarWidgetpage(
      {super.key, required this.index, required this.onTapChanged});

  @override
  State<BottomBarWidgetpage> createState() => _BottomBarWigetpageState();
}

class _BottomBarWigetpageState extends State<BottomBarWidgetpage> {
  @override
  Widget build(BuildContext context) {
    const placeholderitem = Opacity(
      opacity: 0,
      child: Icon(Icons.no_cell),
    );
    return BottomAppBar(
      elevation: 0,
      // shadowColor: Colors.transparent,
      // surfaceTintColor: Colors.transparent,

      height: 87.h,
      // clipBehavior: Clip.none,
      color: Theme.of(context).primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottombarItems(
              0, Image.asset('assets/icons/ic_SearchIcon.png'), "Home"),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WhishListPage()));
            },
            child: bottombarItems(1,
                Image.asset('assets/icons/ic_favouriteIcon.png'), 'Wishlist'),
          ),
          placeholderitem,
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ShortsVideoPage()));
            },
            child: bottombarItems(
                2, Image.asset('assets/icons/ic_VideoIcon.png'), 'Videos'),
          ),
          GestureDetector(
            onTap: () {
              CartAPI.fetchCartData(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            child: bottombarItems(
                3, Image.asset('assets/icons/ic_cartIcon.png'), 'Cart'),
          ),
        ],
      ),
    );
  }

  Widget bottombarItems(int index, Image icon, String label) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(width: 44.w, height: 35.h, child: icon),
          FittedBox(
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
