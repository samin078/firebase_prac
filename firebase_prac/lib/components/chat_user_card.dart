// //import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// //import 'package:skill_chat/models/chat_user.dart';
//
// import '../main.dart';
//
// class ChatUserCard extends StatefulWidget {
//  // final ChatUser user;
//   const ChatUserCard({Key? key}) : super(key: key);
//
//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }
//
// class _ChatUserCardState extends State<ChatUserCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).w * .04, vertical: 4),
//       elevation: 1,
//       //color: Colors.blue.shade100,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//         onTap: () {},
//         child: ListTile(
//           leading: ClipRRect(
//             borderRadius:BorderRadius.circular(mq.height * .3),
//             child: CachedNetworkImage(
//               height: mq.height * .055,
//               width: mq.width * .055,
//               imageUrl: widget.user.image,
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) =>const CircleAvatar(
//                 backgroundColor: Colors.lightGreen,
//                 child: Icon(
//                   CupertinoIcons.person,
//                 ),
//               ),
//             ),
//           ),
//
//           trailing: Container(
//             width: 15,
//             height: 15,
//             decoration: BoxDecoration(
//                 color: Colors.greenAccent.shade400,
//                 borderRadius: BorderRadius.circular(10)
//             ),
//
//           ),
//           // trailing: const Text(
//           //   "12:00 pm",
//           //   style: TextStyle(
//           //     color: Colors.black54,
//           //   ),
//           // ),
//           title: Text(widget.user.name),
//           subtitle: Text(
//             widget.user.about,
//             maxLines: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }