import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user data
      _user = User(
        id: '1',
        name: 'John Doe',
        email: email,
        phone: '+91 9876543210',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to local storage
      await _saveUserToStorage();
      
      _setLoading(false);
    } catch (e) {
      _setError('Login failed. Please try again.');
      _setLoading(false);
    }
  }

  Future<void> register(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user data
      _user = User(
        id: '1',
        name: name,
        email: email,
        phone: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to local storage
      await _saveUserToStorage();
      
      _setLoading(false);
    } catch (e) {
      _setError('Registration failed. Please try again.');
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _user = null;
    await _clearUserFromStorage();
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');
      
      if (userData != null) {
        // Parse user data and set user
        // For now, we'll just check if data exists
        _user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+91 9876543210',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    if (_user == null) return;

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _user = _user!.copyWith(
        name: name ?? _user!.name,
        phone: phone ?? _user!.phone,
        profileImage: profileImage ?? _user!.profileImage,
        updatedAt: DateTime.now(),
      );

      await _saveUserToStorage();
      _setLoading(false);
    } catch (e) {
      _setError('Profile update failed. Please try again.');
      _setLoading(false);
    }
  }

  Future<void> _saveUserToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', _user!.toJson().toString());
    } catch (e) {
      // Handle storage error
    }
  }

  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
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