// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// class CommonSliverHeaderDelegate extends SliverPersistentHeaderDelegate{
//   PreferredSize child;
//   bool islucency;
//   Color backgroundColor;
//   CommonSliverHeaderDelegate({@required this.islucency,@required this.child,this.backgroundColor});
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     double mainHeight = maxExtent - shrinkOffset;//动态获取滑动剩余高度
//     return Container(
//       color: backgroundColor??Colors.white,
//       child: Opacity(
//           opacity:islucency==true&&mainHeight!=maxExtent?((mainHeight / maxExtent)*0.5).clamp(0, 1):1,
//           child: child
//       ),
//     );
//   }
//
//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => this.child.preferredSize.height;
//
//   @override
//   // TODO: implement minExtent
//   double get minExtent => this.child.preferredSize.height;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     // TODO: implement shouldRebuild
//     return true;
//   }
//
// }
