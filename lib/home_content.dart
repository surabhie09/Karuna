import 'package:flutter/material.dart';
import 'models.dart'; // Import Ngo model
import 'chat_screen.dart'; // Import ChatDetailScreen

// --- HOME CONTENT (THE DONOR LANDING PAGE) ---

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _showPostActions(BuildContext context, Ngo ngo) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                ngo.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.teal),
                title: const Text('View Description & Requirements'),
                onTap: () {
                  Navigator.pop(bc); 
                  Navigator.pushNamed(context, '/postDetail', arguments: ngo); 
                },
              ),
              ListTile(
                leading: const Icon(Icons.handshake_rounded, color: Colors.deepOrange),
                title: const Text('Pledge Donation Now'),
                onTap: () {
                  Navigator.pop(bc); 
                  Navigator.pushNamed(context, '/donationForm', arguments: ngo); 
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. Welcome Message & Search Bar
          Padding(
            // ... (Welcome Message & Search Bar content) ...
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hello, Generous Donor!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('Find a cause that moves you.', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // In a full app, this would switch the main tab index to 1 (SearchScreen)
                  },
                  child: AbsorbPointer( 
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search NGOs, Causes, or Needs...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 2. Categories/Tags
          const SectionHeader(title: 'Browse by Category'),
          _CategoryChips(),
          const SizedBox(height: 20),

          // 3. Featured Causes/NGOs
          const SectionHeader(title: 'Urgent & Featured Needs'),
          SizedBox(
            height: 240, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16.0),
              itemCount: mockNgos.length,
              itemBuilder: (context, index) {
                final ngo = mockNgos[index];
                return _NgoCard(ngo: ngo, onTap: () => _showPostActions(context, ngo));
              },
            ),
          ),
          const SizedBox(height: 20),

          // 4. Accepted Pledges
          const SectionHeader(title: 'Accepted Pledges'),
          _AcceptedPledges(),
          const SizedBox(height: 20),

          // 5. Impact Stories/Reviews
          const SectionHeader(title: 'Your Impact in Action (Reviews)'),
          _ImpactStories(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// Helper for Section Titles
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Helper for Categories
class _CategoryChips extends StatelessWidget {
  final List<String> categories = ['Education', 'Health', 'Environment', 'Animal Welfare', 'Disaster Relief'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text(categories[index]),
              backgroundColor: Colors.teal.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
    );
  }
}

// Helper for Featured NGO Card
class _NgoCard extends StatelessWidget {
  final Ngo ngo;
  final VoidCallback onTap;
  const _NgoCard({required this.ngo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // ... (Rest of _NgoCard content) ...
        width: 180,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                ngo.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  color: Colors.teal.shade100,
                  child: const Center(child: Text('Image N/A')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ngo.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(ngo.area, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Need: ${ngo.need.split(',').first}',
                    style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper for Accepted Pledges
class _AcceptedPledges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(left: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mockAcceptedPledges.length,
        itemBuilder: (context, index) {
          final pledge = mockAcceptedPledges[index];
          return _PledgeCard(pledge: pledge);
        },
      ),
    );
  }
}

class _PledgeCard extends StatelessWidget {
  final Pledge pledge;
  const _PledgeCard({required this.pledge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pledge.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            pledge.ngoName,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                pledge.location,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to individual chat screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(ngoName: pledge.ngoName)));
            },
            icon: const Icon(Icons.chat, size: 16, color: Colors.white),
            label: const Text('Chat', style: TextStyle(fontSize: 12, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size(double.infinity, 30),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper for Impact Stories/Reviews
class _ImpactStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(left: 16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _ImpactReviewCard(
            review: "My donation for books helped 5 kids pass their exams! So fulfilling.",
            donorName: "Anjali S.",
          ),
          _ImpactReviewCard(
            review: "I got updates and photos showing where the blankets I donated went. Highly transparent app.",
            donorName: "Priya M.",
          ),
        ],
      ),
    );
  }
}

class _ImpactReviewCard extends StatelessWidget {
  final String review;
  final String donorName;
  const _ImpactReviewCard({required this.review, required this.donorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: Colors.teal, size: 24),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              review,
              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- $donorName',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}