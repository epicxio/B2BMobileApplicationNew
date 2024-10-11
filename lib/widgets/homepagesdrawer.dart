import 'package:coswan/screens/orderhistorypage.dart';
import 'package:coswan/services/logout_api.dart';
import 'package:coswan/screens/login_page.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/storageservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context).user;
    return Drawer(
      clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          ClipPath(
            clipper: Myclipper(),
            child: Container(
              padding: EdgeInsets.only(top: 15.h, bottom: 7.h),
              height: 98.h,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 22.w, right: 18),
                  leading: ClipOval(
                      child: Image.asset('assets/icons/Ic_profileIcon.png')),
                  title: Text(
                    '${userprovider.storename},${userprovider.role}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    userprovider.email,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          userprovider.role == 'Distributor'
              ? SizedBox()
              : _buildListTile(
                  context, 'Order History', 'assets/icons/ic_d5Icon.png', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderHistoryPage()));
                }),
          userprovider.role == 'Distributor'
              ? SizedBox()
              : Divider(
                  height: 0.h,
                  color: const Color.fromRGBO(213, 180, 153, 1),
                ),
          _buildListTile(context, "Log Out", 'assets/icons/ic_d9Icon.png', () {
            StorageService().removeRemUserData();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
            logOutAPi(context);
          }),
          Divider(
            height: 0.h,
            color: const Color.fromRGBO(213, 180, 153, 1),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Version 1.0',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 30.w),
      leading: Image.asset(imagePath),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
      ),
      onTap: onTap,
    );
  }

  // logout api call
  Future logOutAPi(BuildContext context) async {
    await LogoutAPI.logOutAPi(context);
  }
}

class Myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
