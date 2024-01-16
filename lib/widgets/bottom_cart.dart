import 'package:flutter/material.dart';
import 'package:newstore/constants/constants.dart';
import 'package:newstore/widgets/text_widget.dart';

class BottomCart extends StatelessWidget {
  const BottomCart({super.key, this.RowWidget,this.onTap});
  final Widget? RowWidget;
  final Function()?  onTap;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // return ClipRRect(
    //   borderRadius: const BorderRadius.only(
    //     topRight: Radius.circular(15),
    //     topLeft: Radius.circular(15),
    //   ),
    //   child: BottomAppBar(
    //     color: Colors.white,
    //     height: BottomAppBarHeight ?? 80,
    //     // elevation: 10,
    //     child: Padding(
    //       padding: const EdgeInsets.all(15),
    //       child: Column(
    //         mainAxisAlignment:
    //             columnMainAxisAlignment ?? MainAxisAlignment.center,
    //         children: [
    //           columnwidget ?? Container(),
    //           Ink(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(30),
    //               color: color??Colors.green,
    //             ),
    //             child: InkWell(
    //               onTap: onTap ??
    //                   () {
    //                     // route.navigateTo(
    //                     //     Navigate.cart, context, NavigationData());
    //                   },
    //               splashColor: Colors.green.shade400,
    //               highlightColor: Colors.green.shade400,
    //               splashFactory: InkSparkle.splashFactory,
    //               borderRadius: BorderRadius.circular(20),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: SizedBox(
    //                   height: 34,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       rowWidget ??  Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.green.shade200,
    //                   shape: BoxShape.circle,
    //                 ),
    //                 padding: const EdgeInsets.all(8),
    //                 child: CustomTextWidget(
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.bold,
    //                   text: totalItem ?? "",
    //                   fontSize: 14,
    //                 ),
    //               ),
    //                       CustomTextWidget(
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.bold,
    //                         text: cartCenterText ?? "",
    //                         fontSize: 14,
    //                       ),
    //                       Row(
    //                         children: [
    //                           const CustomTextWidget(
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.bold,
    //                             text: "Rs",
    //                             fontSize: 14,
    //                           ),
    //                           const SizedBox(
    //                             width: 5,
    //                           ),
    //                           CustomTextWidget(
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.bold,
    //                             text: totalRs ?? "100",
    //                             fontSize: 14,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.green,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.green.shade400,
            highlightColor: Colors.green.shade400,
            splashFactory: InkSparkle.splashFactory,
            child:RowWidget
          ),
        ),
      ),
    );
  }
}
