import 'package:coswan/screens/login_page.dart';
import 'package:coswan/services/logout_api.dart';
import 'package:coswan/storageservice.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
              extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                    child: Icon(Icons.arrow_back_outlined)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              const AssetImage('assets/images/profileimg.png'),
                          radius: 50.r,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Sara Jones',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color.fromRGBO(191, 191, 191, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(5.r)),
                              backgroundColor: Colors.white),
                          child: Row(
                            children: [
                              Image.asset('assets/icons/ic_order.png'),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(
                                '125',
                                style: TextStyle(
                                    fontSize: 18.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color.fromRGBO(191, 191, 191, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(5.r)),
                              backgroundColor: Colors.white),
                          child: Row(
                            children: [
                              Image.asset('assets/icons/ic_wishlist.png'),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(
                                'Wishlist',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(
                                '125',
                                style: TextStyle(
                                    fontSize: 18.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  _buildListTile(
                      context, 'Your Profile', 'assets/icons/ic_user.png', () {}),
                  _buildListTile(
                      context, 'Payment Methods', 'assets/icons/ic_payment.png',
                      () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const PaymentScreen()));
                  }),
                  _buildListTile(
                      context, 'Settings', 'assets/icons/ic_settings.png', () {}),
                  _buildListTile(
                      context, 'Help Center', 'assets/icons/ic_about.png', () {}),
                  _buildListTile(context, 'Change password',
                      'assets/icons/ic_lock.png', () {}),
                  _buildListTile(
                      context, 'Logout', 'assets/icons/ic_powerButton.png', () {
                    StorageService().removeRemUserData();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                    logOutAPi(context);
                  }),
                ],
              ),
              Positioned(
                  // bottom: 0,
                  right: 155.w,
                  top: 95.h,
                  child: CircleAvatar(
                      maxRadius: 20.r,
                      backgroundColor: const Color.fromRGBO(210, 159, 73, 1),
                      child: Image.asset('assets/icons/ic_pencilIcon.png')))
            ]),
          ),
        ),
      ),
    );
  }
}

// logout api call
Future logOutAPi(BuildContext context) async {
  await LogoutAPI.logOutAPi(context);
}

Widget _buildListTile(
    BuildContext context, String title, String imagePath, VoidCallback onTap) {
  const dividerColor = Color.fromRGBO(210, 159, 73, 1);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: Column(children: [
      ListTile(
        // contentPadding: EdgeInsets.only(left: 30.w),
        leading: Image.asset(imagePath),
        title: Text(
          title,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          color: Color.fromRGBO(210, 159, 73, 1),
        ),
        onTap: onTap,
      ),
      Divider(
        height: 0.h,
        color: dividerColor,
      )
    ]),
  );
}
