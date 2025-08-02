import 'package:flutter/material.dart';
import '../models/hotel.dart';

class HotelProvider extends ChangeNotifier {
  List<Hotel> _hotels = [];
  List<Hotel> _filteredHotels = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 10000;
  int _selectedStarRating = 0;

  List<Hotel> get hotels => _hotels;
  List<Hotel> get filteredHotels => _filteredHotels;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  int get selectedStarRating => _selectedStarRating;

  Future<void> loadHotels() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock hotel data
      _hotels = [
        Hotel(
          id: '1',
          name: 'Taj Palace Hotel',
          description: 'Luxury 5-star hotel in the heart of the city with stunning views and world-class amenities.',
          address: '123 Palace Road, Mumbai, Maharashtra',
          latitude: 19.0760,
          longitude: 72.8777,
          rating: 4.8,
          reviewCount: 1250,
          images: [
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
          ],
          amenities: ['WiFi', 'Pool', 'Spa', 'Restaurant', 'Gym', 'Parking'],
          pricePerNight: 8500,
          currency: 'INR',
          isAvailable: true,
          category: 'Luxury',
          starRating: 5,
        ),
        Hotel(
          id: '2',
          name: 'Marriott Business Hotel',
          description: 'Modern business hotel with conference facilities and convenient location.',
          address: '456 Business Park, Delhi, NCR',
          latitude: 28.6139,
          longitude: 77.2090,
          rating: 4.5,
          reviewCount: 890,
          images: [
            'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
          ],
          amenities: ['WiFi', 'Business Center', 'Restaurant', 'Gym', 'Parking'],
          pricePerNight: 6500,
          currency: 'INR',
          isAvailable: true,
          category: 'Business',
          starRating: 4,
        ),
        Hotel(
          id: '3',
          name: 'Holiday Inn Express',
          description: 'Comfortable and affordable hotel with great value for money.',
          address: '789 Express Lane, Bangalore, Karnataka',
          latitude: 12.9716,
          longitude: 77.5946,
          rating: 4.2,
          reviewCount: 567,
          images: [
            'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800',
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
          ],
          amenities: ['WiFi', 'Breakfast', 'Parking'],
          pricePerNight: 3500,
          currency: 'INR',
          isAvailable: true,
          category: 'Budget',
          starRating: 3,
        ),
        Hotel(
          id: '4',
          name: 'The Oberoi',
          description: 'Ultra-luxury hotel with personalized service and exclusive amenities.',
          address: '321 Luxury Avenue, Kolkata, West Bengal',
          latitude: 22.5726,
          longitude: 88.3639,
          rating: 4.9,
          reviewCount: 2340,
          images: [
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
          ],
          amenities: ['WiFi', 'Pool', 'Spa', 'Restaurant', 'Gym', 'Parking', 'Butler Service'],
          pricePerNight: 12000,
          currency: 'INR',
          isAvailable: true,
          category: 'Luxury',
          starRating: 5,
        ),
        Hotel(
          id: '5',
          name: 'Comfort Inn',
          description: 'Cozy hotel with modern amenities and friendly staff.',
          address: '654 Comfort Street, Chennai, Tamil Nadu',
          latitude: 13.0827,
          longitude: 80.2707,
          rating: 4.0,
          reviewCount: 445,
          images: [
            'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800',
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
          ],
          amenities: ['WiFi', 'Breakfast', 'Parking', 'Restaurant'],
          pricePerNight: 2800,
          currency: 'INR',
          isAvailable: true,
          category: 'Budget',
          starRating: 3,
        ),
      ];

      _filteredHotels = _hotels;
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load hotels. Please try again.');
      _setLoading(false);
    }
  }

  void searchHotels(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    _applyFilters();
  }

  void setStarRating(int rating) {
    _selectedStarRating = rating;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _minPrice = 0;
    _maxPrice = 10000;
    _selectedStarRating = 0;
    _filteredHotels = _hotels;
    notifyListeners();
  }

  void _applyFilters() {
    _filteredHotels = _hotels.where((hotel) {
      // Search query filter
      final matchesSearch = hotel.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hotel.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hotel.address.toLowerCase().contains(_searchQuery.toLowerCase());

      // Category filter
      final matchesCategory = _selectedCategory == 'All' || hotel.category == _selectedCategory;

      // Price filter
      final matchesPrice = hotel.pricePerNight >= _minPrice && hotel.pricePerNight <= _maxPrice;

      // Star rating filter
      final matchesStarRating = _selectedStarRating == 0 || hotel.starRating == _selectedStarRating;

      return matchesSearch && matchesCategory && matchesPrice && matchesStarRating;
    }).toList();

    notifyListeners();
  }

  Hotel? getHotelById(String id) {
    try {
      return _hotels.firstWhere((hotel) => hotel.id == id);
    } catch (e) {
      return null;
    }
  }

  List<String> get categories {
    final categories = _hotels.map((hotel) => hotel.category).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}