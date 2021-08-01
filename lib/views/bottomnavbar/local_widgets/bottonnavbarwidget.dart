// import 'package:abdullahgojektask/utils/constants/mycolors.dart';
// import 'package:flutter/material.dart';

// class BottomNavBarWidget extends StatelessWidget {
//   final void Function(int index) onItemTap;
//   final int selectedIndex;
//   const BottomNavBarWidget({
//     @required this.onItemTap,
//     @required this.selectedIndex,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.timeline,
//               color: getColor(0),
//               size: 32,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.search,
//               color: getColor(1),
//               size: 32,
//             ),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: TextButton(
//               onPressed: null,
//               child: Text(
//                 '\$',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: getColor(2),
//                 ),
//               ),
//             ),
//             label: 'Chat',
//           ),
//         ],
//         currentIndex: selectedIndex,
//         elevation: 20.0,
//         backgroundColor: MyColors.primaryColor,
//         onTap: (index) => onItemTap(index),
//       ),
//     );
//   }
// }
