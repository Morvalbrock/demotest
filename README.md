# Hotel Booking App

A modern Flutter application for hotel booking with UPI payment integration. This app provides a complete hotel booking experience with user authentication, hotel search, booking management, and multiple payment options including UPI.

## Features

### 🏨 Hotel Management
- Browse hotels with detailed information
- Search and filter hotels by location, price, and rating
- View hotel amenities, images, and reviews
- Hotel categorization (Luxury, Business, Budget)

### 📅 Booking System
- Date selection for check-in and check-out
- Guest and room count selection
- Real-time price calculation
- Booking confirmation and management

### 💳 Payment Integration
- **UPI Payment** - Primary payment method with UPI ID validation
- Credit/Debit Card payment
- Net Banking options
- Secure payment processing
- Transaction tracking

### 👤 User Management
- User registration and login
- Profile management
- Booking history
- Favorites and preferences

### 🎨 Modern UI/UX
- Clean and intuitive design
- Responsive layout
- Smooth animations
- Material Design 3 principles

## Payment Methods

### UPI Integration
- Support for all major UPI apps (Google Pay, PhonePe, Paytm, BHIM, etc.)
- UPI ID validation
- Direct UPI app integration
- Transaction status tracking

### Other Payment Options
- Credit/Debit Cards
- Net Banking (SBI, HDFC, ICICI, Axis, etc.)
- Secure payment gateway integration

## Tech Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Local Storage**: Hive & SharedPreferences
- **HTTP Client**: Dio
- **UI Components**: Google Fonts, Cached Network Image
- **Payment**: Razorpay Flutter SDK
- **Maps**: Google Maps Flutter

## Getting Started

### Prerequisites
- Flutter SDK (>=3.0.5)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd hotel_booking_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Configuration

1. **Payment Gateway Setup**:
   - Add your Razorpay API keys in `lib/services/payment_service.dart`
   - Configure UPI merchant details

2. **Google Maps** (Optional):
   - Add Google Maps API key for location features

3. **Assets**:
   - Add hotel images to `assets/images/`
   - Add icons to `assets/icons/`

## Project Structure

```
lib/
├── models/
│   ├── user.dart
│   ├── hotel.dart
│   └── booking.dart
├── providers/
│   ├── auth_provider.dart
│   ├── hotel_provider.dart
│   └── booking_provider.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── hotel_list_screen.dart
│   │   ├── search_screen.dart
│   │   ├── bookings_screen.dart
│   │   └── profile_screen.dart
│   └── hotel/
│       ├── hotel_detail_screen.dart
│       ├── booking_screen.dart
│       └── payment_screen.dart
├── services/
│   └── payment_service.dart
├── utils/
│   └── constants.dart
└── main.dart
```

## Features in Detail

### Hotel Search & Filtering
- Search by hotel name, location, or description
- Filter by category (Luxury, Business, Budget)
- Price range filtering
- Star rating filtering
- Real-time search results

### Booking Process
1. **Hotel Selection**: Browse and select a hotel
2. **Date Selection**: Choose check-in and check-out dates
3. **Guest Details**: Select number of guests and rooms
4. **Payment Method**: Choose UPI, Card, or Net Banking
5. **Payment Processing**: Complete the payment
6. **Confirmation**: Receive booking confirmation

### UPI Payment Flow
1. User enters UPI ID
2. System validates UPI ID format
3. Payment request is processed
4. User completes payment in UPI app
5. Transaction status is updated
6. Booking is confirmed

## Screenshots

[Add screenshots here]

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please contact [your-email@example.com]

---

**Note**: This is a demo application. For production use, implement proper security measures, API integration, and error handling.
