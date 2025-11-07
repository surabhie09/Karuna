// A single-file Flutter application structure for the NGO Connect App (Donor Focus).
// This includes:
// 1. Welcome/Login Chooser Screen.
// 2. DonorHomeScreen (with Bottom Navigation now supporting Home, Search, Chat, Profile).
// 3. Main Tabs (HomeContent, SearchScreen, ChatScreen, ProfileScreen).
// 4. Detailed Sub-screens (PostDetailScreen, DonationForm, ProfileEditScreen).
//
// NOTE: This file still imports 'ngo_flow.dart' for the NGO side routing.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Ensure this is imported for base widgets
import 'ngo_flow.dart'; // Import the NGO flow file

// --- MOCK DATA STRUCTURES ---

class Ngo {
  final String id;
  final String name;
  final String category;
  final String area;
  final String need;
  final double rating;
  final String imageUrl;
  final String description; // Added for Post Details

  Ngo({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.need,
    required this.rating,
    required this.imageUrl,
    this.description = 'A dedicated non-profit organization focused on making a difference in the local community.',
  });
}

class Donation {
  final String ngoName;
  final String item;
  final String date;
  final String status;

  Donation({
    required this.ngoName,
    required this.item,
    required this.date,
    required this.status,
  });
}

// Mock Data Source (Added descriptions for Post Details)
final List<Ngo> mockNgos = [
  Ngo(id: '1', name: 'Clean Rivers Initiative', category: 'Environment', area: 'Mumbai', need: 'Water filters, Volunteers', rating: 4.8, imageUrl: 'https://placehold.co/600x400/228B22/ffffff?text=River+Clean', description: 'Working to clean up local rivers and educate communities on waste management and pollution control.'),
  Ngo(id: '2', name: 'Future Leaders Academy', category: 'Education', area: 'Delhi', need: 'Laptops, Notebooks', rating: 4.5, imageUrl: 'https://placehold.co/600x400/4169E1/ffffff?text=Education', description: 'Providing quality education and resources to children in need, preparing them to be the leaders of tomorrow.'),
  Ngo(id: '3', name: 'Pet Haven Shelter', category: 'Animal Welfare', area: 'Bangalore', need: 'Dog food, Blankets', rating: 4.9, imageUrl: 'https://placehold.co/600x400/FFD700/000000?text=Pets', description: 'Rescuing abandoned pets, providing medical care, and finding loving, permanent homes.'),
  Ngo(id: '4', name: 'Health for All', category: 'Health', area: 'Chennai', need: 'Medical supplies', rating: 4.3, imageUrl: 'https://placehold.co/600x400/800080/ffffff?text=Health+Care', description: 'Offering free health check-ups and essential medicines to remote and underserved populations.'),
];

final List<Donation> mockDonationHistory = [
  Donation(ngoName: 'Future Leaders Academy', item: '₹1000 (Monetary)', date: 'Oct 15, 2024', status: 'Completed'),
  Donation(ngoName: 'Clean Rivers Initiative', item: '5 Water Filters (In-kind)', date: 'Sep 28, 2024', status: 'Ongoing Pickup'),
  Donation(ngoName: 'Pet Haven Shelter', item: '10 Kg Dog Food', date: 'Aug 01, 2024', status: 'Completed'),
];

// --- MAIN APP ENTRY POINT ---

void main() {
  runApp(const NgoConnectApp());
}

class NgoConnectApp extends StatelessWidget {
  const NgoConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NGO Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // Keeping the original Teal color scheme
        primaryColor: const Color(0xFF008080), // Deep Teal
        hintColor: const Color(0xFFFFC300), // Gold/Orange Accent
        scaffoldBackgroundColor: Colors.grey.shade50,
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade700,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white), // Ensures icons are visible
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/donorHome': (context) => const DonorHomeScreen(),
        '/ngoHome': (context) => const NgoHomeScreen(), // Route to NGO flow
        // New Routes for Donor flow detail pages
        '/profileEdit': (context) => const ProfileEditScreen(),
        '/postDetail': (context) => const PostDetailScreen(ngo: null),
        '/donationForm': (context) => const DonationFormScreen(ngo: null),
      },
    );
  }
}

// --- 1. WELCOME / LOGIN CHOICE SCREEN ---

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // App Logo and Tagline
              const Icon(
                Icons.volunteer_activism,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              const Text(
                'NGO Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connecting Hearts with Causes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 60),

              // Donor Login Button
              _LoginButton(
                icon: Icons.person,
                label: 'Login as Donor',
                color: Colors.white,
                textColor: Colors.teal.shade900,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/donorHome');
                },
              ),
              const SizedBox(height: 20),

              // NGO Login Button
              _LoginButton(
                icon: Icons.business,
                label: 'Login as NGO',
                color: Theme.of(context).hintColor, // Accent color
                textColor: Colors.black87,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ngoHome');
                },
              ),

              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  // Action for signing up
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for login buttons
class _LoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _LoginButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: textColor),
      label: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }
}


// --- 2. DONOR HOME SCREEN (WITH BOTTOM NAVIGATION & DRAWER) ---

class DonorHomeScreen extends StatefulWidget {
  const DonorHomeScreen({super.key});

  @override
  State<DonorHomeScreen> createState() => _DonorHomeScreenState();
}

class _DonorHomeScreenState extends State<DonorHomeScreen> {
  int _selectedIndex = 0;
  
  // Updated to include the new ChatScreen tab
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const SearchScreen(),
    const ChatScreen(), // New Chat Page tab
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Helper method to get the current page title
  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home Feed';
      case 1:
        return 'Search Causes';
      case 2:
        return 'Active Pledges & Chats';
      case 3:
        return 'My Profile';
      default:
        return 'NGO Connect';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle()),
        actions: [
          // Keeping notifications/about here for quick access
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
        ],
      ),
      drawer: const AppDrawer(), // Added AppDrawer
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem( // New Chat Tab
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed, // Use fixed for 4 items
      ),
    );
  }
}

// --- 3. HOME CONTENT (THE DONOR LANDING PAGE) ---

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  // Function to show the action sheet upon clicking a post (New Logic)
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
                  Navigator.pop(bc); // Close the modal
                  Navigator.pushNamed(context, '/postDetail', arguments: ngo); // Navigate to PostDetailScreen
                },
              ),
              ListTile(
                leading: const Icon(Icons.handshake_rounded, color: Colors.deepOrange),
                title: const Text('Pledge Donation Now'),
                onTap: () {
                  Navigator.pop(bc); // Close the modal
                  Navigator.pushNamed(context, '/donationForm', arguments: ngo); // Navigate to DonationFormScreen
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hello, Generous Donor!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('Find a cause that moves you.', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),
                // Simplified Search Bar tap action
                GestureDetector(
                  onTap: () {
                    // In a full app, this would switch the main tab index to 1 (SearchScreen)
                  },
                  child: AbsorbPointer( // Makes the TextField non-editable
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search NGOs, Causes, or Needs...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
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

          // 3. Featured Causes/NGOs (Modified to use _showPostActions)
          const SectionHeader(title: 'Urgent & Featured Needs'),
          SizedBox(
            height: 240, // Height for the horizontal list
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

          // 4. Impact Stories/Reviews
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

// Helper for Featured NGO Card (Updated with onTap)
class _NgoCard extends StatelessWidget {
  final Ngo ngo;
  final VoidCallback onTap;
  const _NgoCard({required this.ngo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(ngo.rating.toString(), style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                      const Spacer(),
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

// Helper for Impact Stories/Reviews
class _ImpactStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(left: 16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
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

// --- 4. SEARCH PAGE ---
// (Keeping original search page since no changes requested here)

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Mock filter states
  String _selectedArea = 'All';
  String _selectedCategory = 'All';
  String _selectedResourceType = 'All';

  final List<String> areas = ['All', 'Mumbai', 'Delhi', 'Bangalore', 'Chennai'];
  final List<String> categories = ['All', 'Education', 'Health', 'Environment', 'Animal Welfare'];
  final List<String> resourceTypes = ['All', 'Monetary', 'Items/In-Kind', 'Time (Volunteer)'];

  List<Ngo> _filteredNgos = mockNgos;

  void _applyFilters() {
    setState(() {
      _filteredNgos = mockNgos.where((ngo) {
        final areaMatch = _selectedArea == 'All' || ngo.area == _selectedArea;
        final categoryMatch = _selectedCategory == 'All' || ngo.category == _selectedCategory;
        // Simple resource match based on need string
        final resourceMatch = _selectedResourceType == 'All' ||
            (_selectedResourceType == 'Monetary' && ngo.need.toLowerCase().contains('fund')) ||
            (_selectedResourceType == 'Items/In-Kind' && !ngo.need.toLowerCase().contains('volunteer')) ||
            (_selectedResourceType == 'Time (Volunteer)' && ngo.need.toLowerCase().contains('volunteer'));

        return areaMatch && categoryMatch && resourceMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search & Filter Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Input (Functional)
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Search by NGO name or keyword...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),
              // Filter Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FilterDropdown(
                    label: 'Area',
                    value: _selectedArea,
                    items: areas,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedArea = newValue;
                        });
                        _applyFilters();
                      }
                    },
                  ),
                  _FilterDropdown(
                    label: 'Category',
                    value: _selectedCategory,
                    items: categories,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                        _applyFilters();
                      }
                    },
                  ),
                  _FilterDropdown(
                    label: 'Resource',
                    value: _selectedResourceType,
                    items: resourceTypes,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedResourceType = newValue;
                        });
                        _applyFilters();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // Filtered NGO Results List
        Expanded(
          child: _filteredNgos.isEmpty
              ? const Center(child: Text('No NGOs match your filter criteria.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredNgos.length,
                  itemBuilder: (context, index) {
                    final ngo = _filteredNgos[index];
                    return _SearchNgoResultTile(ngo: ngo);
                  },
                ),
        ),
      ],
    );
  }
}

// Helper for Filter Dropdowns
class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black87),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Helper for Search Results
class _SearchNgoResultTile extends StatelessWidget {
  final Ngo ngo;
  const _SearchNgoResultTile({required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(ngo.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(ngo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${ngo.category} • ${ngo.area}'),
            Text('Urgent Need: ${ngo.need}', style: TextStyle(color: Theme.of(context).hintColor)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Direct donate button action goes straight to form
            Navigator.pushNamed(context, '/donationForm', arguments: ngo);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade400,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            minimumSize: Size.zero,
          ),
          child: const Text('Donate', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        onTap: () {
          // Tap on tile goes to detail page
          Navigator.pushNamed(context, '/postDetail', arguments: ngo);
        },
      ),
    );
  }
}

// --- 5. CHAT PAGE (New Tab) ---

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // Mock list of active chats/pledges
  final List<Map<String, String>> mockChats = const [
    {'name': 'Elderly Care Trust', 'lastMessage': 'The pickup is confirmed for tomorrow.', 'time': '9:30 AM', 'isNew': 'true'},
    {'name': 'Child Hope Foundation', 'lastMessage': 'Thank you for your book donation!', 'time': 'Yesterday', 'isNew': 'false'},
    {'name': 'Animal Savers', 'lastMessage': 'Your pledge has been successfully completed.', 'time': 'Mon', 'isNew': 'false'},
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold needed here because this is a top-level widget in the BottomNavigationBar
    return Scaffold(
      body: ListView.builder(
        itemCount: mockChats.length,
        itemBuilder: (context, index) {
          final chat = mockChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
              child: Text(chat['name']![0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: Text(chat['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(chat['lastMessage']!, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(chat['time']!, style: TextStyle(color: chat['isNew'] == 'true' ? Colors.teal : Colors.grey, fontSize: 12)),
                if (chat['isNew'] == 'true')
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.redAccent,
                    ),
                  )
              ],
            ),
            onTap: () {
              // Navigate to a specific chat/pledge detail screen
              // Using a simple screen here, similar to the previous ChatScreen (now renamed ChatDetailScreen)
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(ngoName: chat['name']!)));
            },
          );
        },
      ),
    );
  }
}

// Helper: Specific chat detail screen
class ChatDetailScreen extends StatelessWidget {
  final String ngoName;
  const ChatDetailScreen({required this.ngoName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $ngoName'),
        backgroundColor: Colors.teal.shade600,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: Colors.white)),
        ],
      ),
      body: Column(
        children: [
          // Mock Chat Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              reverse: true,
              children: [
                _ChatBubble(
                    text: 'We are dispatching our volunteer for pickup at your area tomorrow morning!',
                    isSender: false),
                _ChatBubble(text: 'Great, thank you!', isSender: true),
                _ChatBubble(
                    text: 'Pledge Confirmed: 5x Blankets. Please coordinate pickup via this chat.',
                    isSender: false,
                    isSystem: true),
                _ChatBubble(text: 'Hi, I just pledged 5 blankets for your shelter.', isSender: true),
              ],
            ),
          ),
          // Input area
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Mock send
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper for Chat Bubbles (Moved to the bottom for better organization)
class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool isSystem;

  const _ChatBubble({required this.text, required this.isSender, this.isSystem = false});

  @override
  Widget build(BuildContext context) {
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final color = isSender ? Colors.teal.shade100 : Colors.white;
    final margin = isSender
        ? const EdgeInsets.only(top: 8, bottom: 8, left: 60)
        : const EdgeInsets.only(top: 8, bottom: 8, right: 60);

    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
            )
          ],
        ),
        child: Text(text, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}

// --- 6. PROFILE PAGE (Stateful, Editable, with Donor ID/Bio) ---

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock State Data
  String userName = 'Karan Sharma';
  String userEmail = 'karan.s@example.com';
  String userContact = '+91 98765 43210';
  String userBio = 'Passionate donor focused on education and animal welfare. Always happy to support local community initiatives.';
  final String donorId = 'DC-9347-1985';

  @override
  Widget build(BuildContext context) {
    final int totalDonations = mockDonationHistory.where((d) => d.status.contains('Completed')).length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_rounded, size: 60, color: Colors.teal),
                  ),
                  const SizedBox(height: 12),
                  Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Donor ID: $donorId', style: TextStyle(color: Colors.teal.shade100, fontSize: 14)), // Donor ID added
                  const SizedBox(height: 4),
                  Text('Total Impact: $totalDonations Donations', style: TextStyle(color: Colors.teal.shade100, fontSize: 16)), // Impact added
                  const SizedBox(height: 12),
                  // Edit Button
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                    label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      final updatedData = await Navigator.pushNamed(context, '/profileEdit', arguments: {
                        'name': userName,
                        'contact': userContact,
                        'bio': userBio,
                      }) as Map<String, String>?;

                      if (updatedData != null) {
                        setState(() {
                          userName = updatedData['name'] ?? userName;
                          userContact = updatedData['contact'] ?? userContact;
                          userBio = updatedData['bio'] ?? userBio;
                        });
                      }
                    },
                  )
                ],
              ),
            ),

            // Core Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Contact & Bio'),
                  _ProfileDetailTile(icon: Icons.mail, label: 'Email', value: userEmail),
                  _ProfileDetailTile(icon: Icons.phone, label: 'Contact', value: userContact),
                  _ProfileDetailTile(icon: Icons.info_outline, label: 'Bio', value: userBio), // Bio added
                  const Divider(height: 30),

                  // Donation History
                  const SectionHeader(title: 'Donation Activity'),
                  DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.teal,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.teal,
                          tabs: [
                            Tab(text: 'All Posts'),
                            Tab(text: 'Ongoing'),
                            Tab(text: 'History'),
                          ],
                        ),
                        SizedBox(
                          height: 300, // Fixed height for TabBarView
                          child: TabBarView(
                            children: [
                              // All Posts/Activity
                              _ActivityList(donations: mockDonationHistory),
                              // Currently Ongoing Posts/Pledges
                              _ActivityList(
                                  donations: mockDonationHistory.where((d) => d.status.contains('Ongoing')).toList()),
                              // Donation History
                              _ActivityList(
                                  donations: mockDonationHistory.where((d) => d.status.contains('Completed')).toList()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper for Profile Details
class _ProfileDetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileDetailTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded( // Use expanded to prevent overflow with long bio/contact
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// --- 7. PROFILE EDIT SCREEN (New) ---

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contactController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    if (_nameController.text.isEmpty) {
      _nameController.text = args['name'] ?? '';
      _contactController.text = args['contact'] ?? '';
      _bioController.text = args['bio'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'contact': _contactController.text,
        'bio': _bioController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person_rounded, size: 70, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).hintColor, // Accent color
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: Colors.black87),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Change photo feature not implemented.')),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(_nameController, 'Full Name', Icons.person),
              const SizedBox(height: 15),
              _buildTextField(_contactController, 'Contact Number', Icons.phone, keyboardType: TextInputType.phone),
              const SizedBox(height: 15),
              _buildTextField(_bioController, 'Bio (Max 150 chars)', Icons.info_outline, maxLines: 4, maxLength: 150),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Save Changes', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text, int maxLines = 1, int? maxLength}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}

// --- 8. POST DETAIL SCREEN (for "View Description") ---

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.ngo});
  final Ngo? ngo;

  @override
  Widget build(BuildContext context) {
    // Safely retrieve the NGO object passed via route arguments
    final args = ModalRoute.of(context)?.settings.arguments;
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
                  child: Center(child: Icon(Icons.business_rounded, size: 50, color: Colors.teal)),
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
              selectedNgo.need, // Use 'need' property for requirements
              style: const TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/donationForm', arguments: selectedNgo);
              },
              icon: const Icon(Icons.favorite_rounded, color: Colors.white),
              label: const Text('Pledge Donation', style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor, // Accent color
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

// --- 9. DONATION FORM PAGE (for Item/In-Kind Donation) ---

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

// --- 10. APP DRAWER (Settings/Logout - new location for settings) ---

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.volunteer_activism, size: 40, color: Colors.white),
                SizedBox(height: 8),
                Text('Donor Connect Options', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          _SettingTile(
            icon: Icons.vpn_key_outlined,
            title: 'Change Password',
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          _SettingTile(
            icon: Icons.settings,
            title: 'App Settings',
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          const Divider(),
          _SettingTile(
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
              // Navigate back to the Welcome screen and clear history
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

// --- 11. UTILITY SCREENS & HELPERS ---

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  // Content omitted for brevity, logic remains the same as previous file version.
  final List<Map<String, dynamic>> mockNotifications = const [
    {'title': 'Donation Confirmed', 'subtitle': 'Your pledge is complete.', 'icon': Icons.check_circle, 'color': Colors.green},
    {'title': 'New Message', 'subtitle': 'You have a new message from NGO.', 'icon': Icons.chat, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: mockNotifications.length,
        itemBuilder: (context, index) {
          final notif = mockNotifications[index];
          return ListTile(
            leading: Icon(notif['icon'], color: notif['color']),
            title: Text(notif['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(notif['subtitle']),
          );
        },
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About NGO Connect')),
      body: const Center(child: Text('App version 1.0. Read about our mission here.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))),
    );
  }
}


// Shared Helper Widgets (unchanged)

class _ActivityList extends StatelessWidget {
  final List<Donation> donations;
  const _ActivityList({required this.donations});

  @override
  Widget build(BuildContext context) {
    if (donations.isEmpty) {
      return const Center(child: Text('No activity found for this section.', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final d = donations[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: d.status.contains('Completed') ? Colors.teal : Colors.deepOrange,
            child: Icon(d.status.contains('Completed') ? Icons.check : Icons.delivery_dining, color: Colors.white),
          ),
          title: Text('${d.item} to ${d.ngoName}'),
          subtitle: Text(d.date),
          trailing: Text(d.status.split('(').first.trim(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: d.status.contains('Completed') ? Colors.green.shade700 : Colors.deepOrange)),
        );
      },
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _SettingTile({required this.icon, required this.title, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black54),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}