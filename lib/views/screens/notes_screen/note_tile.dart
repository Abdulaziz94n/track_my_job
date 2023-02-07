// // import 'package:flutter/material.dart';

// // import '../../../enums/note_priority.dart';
// // import '../../../extensions/build_context_extension.dart';
// // import '../../../extensions/string_extension.dart';
// // import '../../../extensions/widget_extension.dart';
// // import '../../shared/app_text.dart';

// // class NoteCustomTile extends StatelessWidget {
// //   const NoteCustomTile({
// //     super.key,
// //     required this.title,
// //     required this.subtitle,
// //     required this.date,
// //     required this.priority,
// //   });
// //   final String title;
// //   final String subtitle;
// //   final String date;
// //   final NotePriority priority;
// //   @override
// //   Widget build(BuildContext context) {
// //     final textPadding = EdgeInsets.fromLTRB(8, 8, 0, 8);
// //     return Stack(
// //       children: [
// //         AppText(
// //           style: context.appTextTheme.bodyLarge!,
// //           text: title.capitalizeFirstOfEach,
// //         ),
// //         Positioned(
// //           top: 20,
// //           right: 0,
// //           left: 10,
// //           child: ColoredBox(
// //             color: Colors.red,
// //             child: AppText(
// //               style: context.appTextTheme.bodyLarge!,
// //               text: title.capitalizeFirstOfEach,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ).colored();
// //   }
// // }

// import 'package:flutter/material.dart';

// import '../../../enums/note_priority.dart';
// import '../../../extensions/build_context_extension.dart';
// import '../../../extensions/string_extension.dart';
// import '../../shared/app_text.dart';

// class NoteCustomTile extends StatelessWidget {
//   const NoteCustomTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.date,
//     required this.priority,
//   });
//   final String title;
//   final String subtitle;
//   final String date;
//   final NotePriority priority;
//   @override
//   Widget build(BuildContext context) {
//     final textPadding = EdgeInsets.fromLTRB(8, 8, 0, 8);
//     return LimitedBox(
//       maxHeight: 0100,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Flexible(
//             flex: 2,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: AppText(
//                     style: context.appTextTheme.bodyMedium!,
//                     text: subtitle.capitalizeFirst * 2,
//                     padding: textPadding,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Flexible(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 AppText(
//                   style: context.appTextTheme.bodyLarge!,
//                   text: date.capitalizeFirstOfEach,
//                   padding: textPadding,
//                 ),
//                 Icon(Icons.abc),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// /*
// // import 'package:flutter/material.dart';

// // import '../../../enums/note_priority.dart';
// // import '../../../extensions/build_context_extension.dart';
// // import '../../../extensions/string_extension.dart';
// // import '../../../extensions/widget_extension.dart';
// // import '../../shared/app_text.dart';

// // class NoteCustomTile extends StatelessWidget {
// //   const NoteCustomTile({
// //     super.key,
// //     required this.title,
// //     required this.subtitle,
// //     required this.date,
// //     required this.priority,
// //   });
// //   final String title;
// //   final String subtitle;
// //   final String date;
// //   final NotePriority priority;
// //   @override
// //   Widget build(BuildContext context) {
// //     final textPadding = EdgeInsets.fromLTRB(8, 8, 0, 8);
// //     return Stack(
// //       children: [
// //         AppText(
// //           style: context.appTextTheme.bodyLarge!,
// //           text: title.capitalizeFirstOfEach,
// //         ),
// //         Positioned(
// //           top: 20,
// //           right: 0,
// //           left: 10,
// //           child: ColoredBox(
// //             color: Colors.red,
// //             child: AppText(
// //               style: context.appTextTheme.bodyLarge!,
// //               text: title.capitalizeFirstOfEach,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ).colored();
// //   }
// // }

// import 'package:flutter/material.dart';

// import '../../../enums/note_priority.dart';
// import '../../../extensions/build_context_extension.dart';
// import '../../../extensions/string_extension.dart';
// import '../../shared/app_text.dart';

// class NoteCustomTile extends StatelessWidget {
//   const NoteCustomTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.date,
//     required this.priority,
//   });
//   final String title;
//   final String subtitle;
//   final String date;
//   final NotePriority priority;
//   @override
//   Widget build(BuildContext context) {
//     final textPadding = EdgeInsets.fromLTRB(8, 8, 0, 8);
//     return IntrinsicHeight(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppText(
//                   style: context.appTextTheme.bodyMedium!,
//                   text: subtitle.capitalizeFirst * 2,
//                   padding: textPadding,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 AppText(
//                   style: context.appTextTheme.bodyLarge!,
//                   text: date.capitalizeFirstOfEach,
//                   padding: textPadding,
//                 ),
//                 Icon(Icons.abc),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//  */