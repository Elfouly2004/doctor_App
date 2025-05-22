import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("المساعد الطبي")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final messages = context.read<ChatCubit>().messages;

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: msg.isUser
                              ? Colors.blueAccent
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "اكتب أعراضك...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(text);
                      controller.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
