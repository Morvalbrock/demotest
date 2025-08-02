import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color accent = Color(0xFF10B981);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF1E293B);
  static const Color textLight = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );
  
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
}

class AppSizes {
  static const double padding = 16.0;
  static const double paddingSmall = 8.0;
  static const double paddingLarge = 24.0;
  static const double radius = 8.0;
  static const double radiusLarge = 12.0;
}

class AppStrings {
  // App
  static const String appName = 'Hotel Booking App';
  static const String appTagline = 'Find your perfect stay';
  
  // Navigation
  static const String home = 'Home';
  static const String search = 'Search';
  static const String bookings = 'Bookings';
  static const String profile = 'Profile';
  
  // Auth
  static const String login = 'Login';
  static const String register = 'Register';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  
  // Hotel
  static const String searchHotels = 'Search Hotels';
  static const String popularHotels = 'Popular Hotels';
  static const String nearbyHotels = 'Nearby Hotels';
  static const String hotelDetails = 'Hotel Details';
  static const String bookNow = 'Book Now';
  static const String pricePerNight = 'per night';
  
  // Booking
  static const String selectDates = 'Select Dates';
  static const String checkIn = 'Check-in';
  static const String checkOut = 'Check-out';
  static const String guests = 'Guests';
  static const String rooms = 'Rooms';
  static const String totalPrice = 'Total Price';
  static const String confirmBooking = 'Confirm Booking';
  static const String bookingConfirmed = 'Booking Confirmed!';
  
  // Payment
  static const String payment = 'Payment';
  static const String upiPayment = 'UPI Payment';
  static const String cardPayment = 'Card Payment';
  static const String payNow = 'Pay Now';
  static const String paymentSuccess = 'Payment Successful!';
  static const String paymentFailed = 'Payment Failed';
  
  // Profile
  static const String myProfile = 'My Profile';
  static const String editProfile = 'Edit Profile';
  static const String settings = 'Settings';
  static const String logout = 'Logout';
  
  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String view = 'View';
}