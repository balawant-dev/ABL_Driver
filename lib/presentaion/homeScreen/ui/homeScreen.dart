import 'package:abldriver/WebServices/app_url.dart';
import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/profile/provider/profileProvider.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../profile/ui/profileScreen.dart';
import '../provider/homeProvider.dart';
import 'newOrderScreen.dart';
import 'onGoingOrder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
      final homeProvider =
      Provider.of<HomeProvider>(context, listen: false);
      homeProvider.fetchHomeHederData();
      homeProvider.fetchNewOrderData();
    });
  }
  bool isOn = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider,HomeProvider>(
        builder: (context, provider,homeProvider, child){
         return Scaffold(
           backgroundColor: ColorResource.white,
            body: CustomPageRefresher(
                onRefresh: () async{
                  final profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);
                  final homeProvider =
                  Provider.of<HomeProvider>(context, listen: false);
                  await profileProvider.fetchProfileData();
                  await homeProvider.fetchHomeHederData();
                  await homeProvider.fetchNewOrderData();
                 // await homeProvider.fetchOnGoingOrderData();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                navPush(context: context, action: ProfileScreen());
                               // navPushLeft(context: context, action: ProfileScreen(), duration:300);
                                //navPushRight(context: context, action: ProfileScreen(), duration:300);
                                //navPushTop(context: context, action: ProfileScreen(), duration: 300);
                               // navPushFade(context: context, action: ProfileScreen(), duration: 300);
                               // navPushBottom(context: context, action: ProfileScreen(), duration: 300);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: ClipOval(
                                      child: Image.network(
                                        "${AppUrl.baseUrl}/${provider.getProfileData?.data?.profileImage }",
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.person,
                                            size: 25,
                                            color: Colors.white,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText('Hello',size: 18,weight: FontWeight.w500,color: ColorResource.green,),
                                      CustomText(provider.getProfileData?.data?.name ?? "",size: 18,weight: FontWeight.w500,color: ColorResource.green,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                final driverId = provider.getProfileData?.data?.sId ?? "";
                                if (driverId.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Driver ID not found")),
                                  );
                                  return;
                                }
                                final newStatus = isOn ? "inactive" : "active";
                                await homeProvider.changeDriverStatus(
                                  driverId: driverId,
                                  status: newStatus,
                                );
                                setState(() {
                                  isOn = !isOn;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Driver is now ${newStatus.toUpperCase()}"),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Container(
                                width: 51,
                                height: 31,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: isOn ? ColorResource.green : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Align(
                                  alignment: isOn
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            CustomImageView(
                              imagePath: AppImages.notification,
                              height: 45,
                              width: 45,
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CardDetails(
                              color1: ColorResource.card11,
                              color2: ColorResource.card12,
                              timeing: "Today’s Earning",
                              amount: homeProvider.getHomeHederData?.data?.today?.totalIncome ?? 0,
                              completed: homeProvider.getHomeHederData?.data?.today?.totalOrders ?? 0,
                            ),
                            CardDetails(
                              color1: ColorResource.card21,
                              color2: ColorResource.card22,
                              timeing: "Weekly Earning",
                              amount: homeProvider.getHomeHederData?.data?.last7Days?.totalIncome ?? 0,
                              completed: homeProvider.getHomeHederData?.data?.last7Days?.totalOrders ?? 0,
                            ),
                            CardDetails(
                              color1: ColorResource.card31,
                              color2: ColorResource.card32,
                              timeing: "Monthly Earning",
                              amount: homeProvider.getHomeHederData?.data?.last30Days?.totalIncome ?? 0,
                              completed: homeProvider.getHomeHederData?.data?.last30Days?.totalOrders ?? 0,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorResource.gray1,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              _toggleItem(title: "New Orders", index: 0),
                              _toggleItem(title: "Ongoing Orders", index: 1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        selectedIndex == 0
                            ? NewOrderScreen()
                            : OnGoingOrder(),

                      ],
                    ),
                  ),
                ),
            )
          );
        }
    );
  }


  Widget CardDetails({
    required Color color1,
    required Color color2,
    required int amount,
    required int completed,
    required String timeing,
  }) {
    return Container(
      width: 105,
      height: 105,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [color1, color2],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(
              timeing,
              size: 11,
              weight: FontWeight.w600,
              color: ColorResource.white,
            ),
            SizedBox(height: 5,),
            // CustomText(
            //   '₹${amount.toString()}',
            //   size: 14,
            //   weight: FontWeight.w600,
            //   color: ColorResource.white,
            // ),
            CustomText('₹ $amount',
                size: 18,
                weight: FontWeight.bold,
                color: Colors.white),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Completed',
                    size: 10,
                    weight: FontWeight.w400,
                    color: Colors.white70),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    completed.toString(),
                    size: 10,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              ],
            )
            // CustomText(
            //   'Order Completed',
            //   size: 8,
            //   weight: FontWeight.w400,
            //   color: ColorResource.white,
            // ),
            // SizedBox(height: 5,),
            // CustomText(
            //   completed.toString(),
            //   size: 8,
            //   weight: FontWeight.w400,
            //   color: ColorResource.white,
            // ),
          ],
        ),
      ),
    );
  }




  Widget _toggleItem({
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected
                ? ColorResource.buttonBackground
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: CustomText(
            title,
            size: 14,
            weight: FontWeight.w500,
            color: isSelected
                ? ColorResource.white
                : ColorResource.gray,
          ),
        ),
      ),
    );
  }
}






















//
// import 'package:abldriver/WebServices/app_url.dart';
// import 'package:abldriver/app/theme/color_resource.dart';
// import 'package:abldriver/core/constants/app_images.dart';
// import 'package:abldriver/presentaion/profile/provider/profileProvider.dart';
// import 'package:abldriver/widget/customImageView.dart';
// import 'package:abldriver/widget/customPageRefresher.dart';
// import 'package:abldriver/widget/custom_text.dart';
// import 'package:abldriver/widget/navigator_method.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../profile/ui/profileScreen.dart';
// import '../provider/homeProvider.dart';
// import 'newOrderScreen.dart';
// import 'onGoingOrder.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//
//   bool isOn = false;
//   int selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//
//     _controller.forward();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
//       final homeProvider =
//       Provider.of<HomeProvider>(context, listen: false);
//       homeProvider.fetchHomeHederData();
//       homeProvider.fetchNewOrderData();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Widget _animatedSection({required Widget child}) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, _) {
//         return Transform.translate(
//           offset: Offset(0, 80 * (1 - _controller.value)),
//           child: Opacity(
//             opacity: _controller.value,
//             child: child,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<ProfileProvider, HomeProvider>(
//       builder: (context, provider, homeProvider, child) {
//         return Scaffold(
//           backgroundColor: ColorResource.white,
//           body: CustomPageRefresher(
//             onRefresh: () async {
//               await provider.fetchProfileData();
//               await homeProvider.fetchHomeHederData();
//               await homeProvider.fetchNewOrderData();
//             },
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//
//                     const SizedBox(height: 30),
//
//                     /// TOP HEADER
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             navPush(context: context, action: ProfileScreen());
//                           },
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 20,
//                                 child: ClipOval(
//                                   child: Image.network(
//                                     "${AppUrl.baseUrl}/${provider.getProfileData
//                                         ?.data?.profileImage}",
//                                     width: 40,
//                                     height: 40,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (_, __, ___) =>
//                                     const Icon(Icons.person, size: 25),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText('Hello',
//                                       size: 18,
//                                       weight: FontWeight.w500,
//                                       color: ColorResource.green),
//                                   CustomText(
//                                       provider.getProfileData?.data?.name ?? "",
//                                       size: 18,
//                                       weight: FontWeight.w500,
//                                       color: ColorResource.green),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         CustomImageView(
//                           imagePath: AppImages.notification,
//                           height: 45,
//                           width: 45,
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 15),
//
//                     /// 🔥 ANIMATED CARDS
//                     _animatedSection(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CardDetails(
//                             color1: ColorResource.card11,
//                             color2: ColorResource.card12,
//                             timeing: "Today’s Earning",
//                             amount: homeProvider.getHomeHederData?.data?.today
//                                 ?.totalIncome ?? 0,
//                             completed: homeProvider.getHomeHederData?.data
//                                 ?.today?.totalOrders ?? 0,
//                           ),
//                           CardDetails(
//                             color1: ColorResource.card21,
//                             color2: ColorResource.card22,
//                             timeing: "Weekly Earning",
//                             amount: homeProvider.getHomeHederData?.data
//                                 ?.last7Days?.totalIncome ?? 0,
//                             completed: homeProvider.getHomeHederData?.data
//                                 ?.last7Days?.totalOrders ?? 0,
//                           ),
//                           CardDetails(
//                             color1: ColorResource.card31,
//                             color2: ColorResource.card32,
//                             timeing: "Monthly Earning",
//                             amount: homeProvider.getHomeHederData?.data
//                                 ?.last30Days?.totalIncome ?? 0,
//                             completed: homeProvider.getHomeHederData?.data
//                                 ?.last30Days?.totalOrders ?? 0,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 15),
//
//                     /// TOGGLE
//                     Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: ColorResource.gray1,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Row(
//                         children: [
//                           _toggleItem(title: "New Orders", index: 0),
//                           _toggleItem(title: "Ongoing Orders", index: 1),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     /// 🔥 ANIMATED LIST
//                     _animatedSection(
//                       child: selectedIndex == 0
//                           ? const NewOrderScreen()
//                           : const OnGoingOrder(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   Widget CardDetails({
//     required Color color1,
//     required Color color2,
//     required int amount,
//     required int completed,
//     required String timeing,
//   }) {
//     return Container(
//       width: 105,
//       height: 105,
//       clipBehavior: Clip.antiAlias,
//       decoration: ShapeDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.50, -0.00),
//           end: Alignment(0.50, 1.00),
//           colors: [color1, color2],
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       child: Padding(
//           padding: EdgeInsets.all(10),
//         child: Column(
//           children: [
//             CustomText(
//               timeing,
//               size: 11,
//               weight: FontWeight.w600,
//               color: ColorResource.white,
//             ),
//             SizedBox(height: 5,),
//             CustomText(
//               '₹${amount.toString()}',
//               size: 14,
//               weight: FontWeight.w600,
//               color: ColorResource.white,
//             ),
//             Spacer(),
//             CustomText(
//               'Order Completed',
//               size: 8,
//               weight: FontWeight.w400,
//               color: ColorResource.white,
//             ),
//             SizedBox(height: 5,),
//             CustomText(
//               completed.toString(),
//               size: 8,
//               weight: FontWeight.w400,
//               color: ColorResource.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _toggleItem({
//     required String title,
//     required int index,
//   }) {
//     final bool isSelected = selectedIndex == index;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           alignment: Alignment.center,
//           height: 50,
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? ColorResource.buttonBackground
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: CustomText(
//             title,
//             size: 14,
//             weight: FontWeight.w500,
//             color: isSelected
//                 ? ColorResource.white
//                 : ColorResource.gray,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
