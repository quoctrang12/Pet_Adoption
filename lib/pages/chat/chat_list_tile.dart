import 'package:flutter/material.dart';
import 'package:pet_adopt/const.dart';
import 'package:pet_adopt/models/chats_model.dart';

class ChatListTile extends StatefulWidget {
  final Chats chats;

  const ChatListTile({Key? key, required this.chats}) : super(key: key);

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: red,
              image: DecorationImage(
                image: AssetImage(widget.chats.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chats.name,
                  style: widget.chats.unread
                      ? poppins.copyWith(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.bold,
                        )
                      : poppins.copyWith(
                          fontSize: 16,
                          color: black.withOpacity(0.5),
                        ),
                ),
                Row(
                  children: [
                    Text(
                      widget.chats.message,
                      style: widget.chats.unread
                          ? poppins.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                          : poppins.copyWith(
                              color: black.withOpacity(0.5),
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.chats.time,
                    ),
                  ],
                )
              ],
            ),
          ),
          widget.chats.unread
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blue,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
