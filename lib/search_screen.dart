import 'package:flutter/material.dart';
import 'models.dart'; // Import Ngo and mockNgos

// --- SEARCH PAGE ---

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    // ... (Rest of _FilterDropdown content) ...
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
          Navigator.pushNamed(context, '/postDetail', arguments: ngo);
        },
      ),
    );
  }
}