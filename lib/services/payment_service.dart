import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  static Razorpay? _razorpay;
  
  static void initialize() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  static void dispose() {
    _razorpay?.clear();
  }

  static Future<bool> processUPIPayment({
    required double amount,
    required String currency,
  }) async {
    try {
      // For demo purposes, we'll simulate UPI payment
      // In a real app, you would integrate with actual UPI payment gateways
      
      // Simulate payment processing time
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate 90% success rate
      final random = DateTime.now().millisecond % 10;
      return random < 9; // 90% success rate
    } catch (e) {
      return false;
    }
  }

  static Future<bool> processCardPayment({
    required double amount,
    required String currency,
  }) async {
    try {
      // Simulate card payment processing
      await Future.delayed(const Duration(seconds: 3));
      
      // Simulate 85% success rate
      final random = DateTime.now().millisecond % 10;
      return random < 8; // 85% success rate
    } catch (e) {
      return false;
    }
  }

  static Future<bool> processNetBankingPayment({
    required double amount,
    required String currency,
  }) async {
    try {
      // Simulate net banking payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate 80% success rate
      final random = DateTime.now().millisecond % 10;
      return random < 8; // 80% success rate
    } catch (e) {
      return false;
    }
  }

  static Future<bool> processRazorpayPayment({
    required double amount,
    required String currency,
    required String orderId,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) async {
    try {
      if (_razorpay == null) {
        initialize();
      }

      final options = {
        'key': 'rzp_test_YOUR_KEY_HERE', // Replace with your Razorpay test key
        'amount': (amount * 100).toInt(), // Amount in paise
        'currency': currency,
        'name': 'Hotel Booking App',
        'description': 'Hotel Booking Payment',
        'order_id': orderId,
        'prefill': {
          'name': customerName,
          'email': customerEmail,
          'contact': customerPhone,
        },
        'theme': {
          'color': '#2563EB',
        },
      };

      _razorpay!.open(options);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> launchUPIApp({
    required String upiId,
    required double amount,
    required String currency,
    String? merchantName,
    String? merchantCode,
  }) async {
    try {
      // Create UPI URL
      final upiUrl = 'upi://pay?pa=$upiId&pn=${merchantName ?? 'Hotel Booking'}&am=$amount&cu=$currency&mc=${merchantCode ?? '123456'}';
      
      final uri = Uri.parse(upiUrl);
      
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment
    print('Payment Success: ${response.paymentId}');
  }

  static void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    print('Payment Error: ${response.code} - ${response.message}');
  }

  static void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print('External Wallet: ${response.walletName}');
  }

  // UPI ID validation
  static bool isValidUPIId(String upiId) {
    // Basic UPI ID validation
    final upiRegex = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z]{3,}$');
    return upiRegex.hasMatch(upiId);
  }

  // Generate transaction ID
  static String generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'TXN$timestamp$random';
  }

  // Format amount for display
  static String formatAmount(double amount, String currency) {
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  // Get supported UPI apps
  static List<String> getSupportedUPIApps() {
    return [
      'Google Pay',
      'PhonePe',
      'Paytm',
      'BHIM',
      'Amazon Pay',
      'Mobikwik',
      'Freecharge',
      'Airtel Money',
    ];
  }
}