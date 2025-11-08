import 'package:flutter/material.dart';
import 'models.dart'; // Import Ngo and mockNgos

// --- POST DETAIL SCREEN (for "View Description") ---

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.ngo});
  final Ngo? ngo;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    // Use a null check on args to safely retrieve Ngo, defaulting to the first mock NGO if needed
    final Ngo selectedNgo = (ngo ?? args) as Ngo? ?? mockNgos.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                selectedNgo.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(15)),
                  child: const Center(child: Icon(Icons.business_rounded, size: 50, color: Colors.teal)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedNgo.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            const Text(
              'About the Organization',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(selectedNgo.description, style: const TextStyle(fontSize: 16)),
            const Divider(height: 30),
            const Text(
              'Current Requirements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              selectedNgo.need,
              style: const TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Simulate donation pledge
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Donation pledged successfully! Check your Chats tab.')),
                );
                // Navigate back to Home
                Navigator.pop(context);
              },
              icon: const Icon(Icons.favorite_rounded, color: Colors.white),
              label: const Text('Pledge Donation', style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}