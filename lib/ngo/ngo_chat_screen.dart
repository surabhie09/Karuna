import 'package:flutter/material.dart';

class NgoChatScreen extends StatelessWidget {
  const NgoChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 60, color: Colors.teal),
          SizedBox(height: 10),
          Text(
            'Message Donors & Partners',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Your direct communication hub with all stakeholders.',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          // In a real app, this would lead to a screen showing chat threads.
          ElevatedButton(
            onPressed: null, // Placeholder action
            child: Text('Start a New Conversation'),
          )
        ],
      ),
    );
  }
}