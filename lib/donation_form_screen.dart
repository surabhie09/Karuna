import 'package:flutter/material.dart';
import 'models.dart'; // Import Ngo and mockNgos

// --- DONATION FORM PAGE (for Item/In-Kind Donation) ---

class DonationFormScreen extends StatelessWidget {
  const DonationFormScreen({super.key, required this.ngo});
  final Ngo? ngo;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Ngo selectedNgo = (ngo ?? args) as Ngo? ?? mockNgos.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pledge to ${selectedNgo.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pledging for needs: ${selectedNgo.need}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Divider(),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'What are you donating (e.g., 10 Kgs Rice, 5 Books)?',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Notes for NGO (e.g., best time for pickup)',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Simulate donation submission
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Donation pledged successfully! Check your Chats tab.')),
                );
                // Navigate back to Home
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm Pledge', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}