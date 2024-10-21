import 'package:coswan/services/login_api.dart';
import 'package:coswan/storageservice.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/screens/login_page.dart';
import 'package:coswan/screens/swipepageview/swipepageone.dart';
import 'package:coswan/screens/swipepageview/swipepagetwo.dart';
import 'package:coswan/screens/swipepageview/swipepagthree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SwipePageView extends StatefulWidget {
  const SwipePageView({super.key});

  @override
  State<SwipePageView> createState() => _SwipePageViewState();
}

class _SwipePageViewState extends State<SwipePageView> {
  late final PageController _pageController;
  int activePage = 0;
  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    StorageService().storage.initStorage;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void leftArrow() {
    if (activePage > 0) {
      _pageController.animateToPage(activePage - 1,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  void rightArrow() {
    if (activePage != 2) {
      _pageController.animateToPage(activePage + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {
      if (StorageService().storage.hasData('email')) {
        final email = StorageService().getEmail()!.toString();
        final password = StorageService().getPWD()!.toString();
        postData(email, password, true);
        print(email);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: gradient,
          ),
          child: Scaffold(
              extendBody: true,
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                forceMaterialTransparency: true,
                actions: [
                  TextButton(
                    onPressed: () {
                      if (StorageService().storage.hasData('email')) {
        final email = StorageService().getEmail()!.toString();
        final password = StorageService().getPWD()!.toString();
        postData(email, password, true);
        print(email);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        // height: 27.h,
                      ),
                    ),
                  )
                ],
              ),
              body: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        activePage = page;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[index % _pages.length];
                    },
                  ),
                  Positioned(
                    height: 100.h,
                    left: 0.w,
                    //top: 799.h,
                    bottom: 50.h,
                    child: GestureDetector(
                        onTap: leftArrow,
                        child:
                            Image.asset('assets/icons/ic_rightarrowIcon.png')),
                  ),
                  Positioned(
                    left: 166.w,
                    right: 0.w,
                    bottom: 50.h,
                    height: 100.h,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: SwapEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: const Color.fromRGBO(255, 255, 255, 1),
                        // dotHeight: 30,
                        // dotWidth: 30
                      ),
                    ),
                  ),
                  Positioned(
                    height: 100.h,
                    right: 15.w,
                    //top: 799.h,
                    bottom: 50.h,
                    child: GestureDetector(
                        onTap: rightArrow,
                        child:
                            Image.asset('assets/icons/ic_leftarrowIcon.png')),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> postData(identifier, password, isChecked) async {
    await LoginAPI.postData(context, identifier, password, isChecked);
  }
}
