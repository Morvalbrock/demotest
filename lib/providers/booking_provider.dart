import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';
import '../models/hotel.dart';
import '../models/user.dart';
import '../services/payment_service.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];
  Booking? _currentBooking;
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => _bookings;
  Booking? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBookings() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Load from local storage
      final prefs = await SharedPreferences.getInstance();
      final bookingsData = prefs.getStringList('bookings') ?? [];
      
      // For now, we'll use mock data
      _bookings = [];
      _setLoading(false);
    } catch (e) {
      _setError('Failed to load bookings. Please try again.');
      _setLoading(false);
    }
  }

  Future<void> createBooking({
    required Hotel hotel,
    required User user,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required int rooms,
    required PaymentMethod paymentMethod,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Calculate total price
      final numberOfNights = checkOut.difference(checkIn).inDays;
      final totalPrice = hotel.pricePerNight * numberOfNights * rooms;

      // Create booking
      _currentBooking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        user: user,
        hotel: hotel,
        checkIn: checkIn,
        checkOut: checkOut,
        guests: guests,
        rooms: rooms,
        totalPrice: totalPrice,
        currency: hotel.currency,
        status: BookingStatus.pending,
        paymentStatus: PaymentStatus.pending,
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _setLoading(false);
    } catch (e) {
      _setError('Failed to create booking. Please try again.');
      _setLoading(false);
    }
  }

  Future<bool> processPayment() async {
    if (_currentBooking == null) return false;

    _setLoading(true);
    _clearError();

    try {
      // Process payment based on method
      bool paymentSuccess = false;
      
      switch (_currentBooking!.paymentMethod) {
        case PaymentMethod.upi:
          paymentSuccess = await PaymentService.processUPIPayment(
            amount: _currentBooking!.totalPrice,
            currency: _currentBooking!.currency,
          );
          break;
        case PaymentMethod.card:
          paymentSuccess = await PaymentService.processCardPayment(
            amount: _currentBooking!.totalPrice,
            currency: _currentBooking!.currency,
          );
          break;
        case PaymentMethod.netBanking:
          paymentSuccess = await PaymentService.processNetBankingPayment(
            amount: _currentBooking!.totalPrice,
            currency: _currentBooking!.currency,
          );
          break;
      }

      if (paymentSuccess) {
        // Update booking status
        _currentBooking = _currentBooking!.copyWith(
          status: BookingStatus.confirmed,
          paymentStatus: PaymentStatus.completed,
          transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
          updatedAt: DateTime.now(),
        );

        // Add to bookings list
        _bookings.add(_currentBooking!);
        
        // Save to local storage
        await _saveBookingsToStorage();
        
        _setLoading(false);
        return true;
      } else {
        _setError('Payment failed. Please try again.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Payment processing failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    _setLoading(true);
    _clearError();

    try {
      final bookingIndex = _bookings.indexWhere((b) => b.id == bookingId);
      if (bookingIndex != -1) {
        _bookings[bookingIndex] = _bookings[bookingIndex].copyWith(
          status: BookingStatus.cancelled,
          updatedAt: DateTime.now(),
        );
        
        await _saveBookingsToStorage();
      }
      
      _setLoading(false);
    } catch (e) {
      _setError('Failed to cancel booking. Please try again.');
      _setLoading(false);
    }
  }

  void clearCurrentBooking() {
    _currentBooking = null;
    notifyListeners();
  }

  List<Booking> getBookingsByStatus(BookingStatus status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  List<Booking> getBookingsByPaymentStatus(PaymentStatus status) {
    return _bookings.where((booking) => booking.paymentStatus == status).toList();
  }

  Future<void> _saveBookingsToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookingsData = _bookings.map((booking) => booking.toJson().toString()).toList();
      await prefs.setStringList('bookings', bookingsData);
    } catch (e) {
      // Handle storage error
    }
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