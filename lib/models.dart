// Mock Data Structures
class Ngo {
  final String id;
  final String name;
  final String category;
  final String area;
  final String need;
  final double rating;
  final String imageUrl;
  final String description;

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

// Mock Data Source
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