import 'hotel.dart';
import 'user.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

enum PaymentMethod {
  upi,
  card,
  netBanking,
}

class Booking {
  final String id;
  final User user;
  final Hotel hotel;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final int rooms;
  final double totalPrice;
  final String currency;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final PaymentMethod paymentMethod;
  final String? transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.user,
    required this.hotel,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.rooms,
    required this.totalPrice,
    required this.currency,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      user: User.fromJson(json['user']),
      hotel: Hotel.fromJson(json['hotel']),
      checkIn: DateTime.parse(json['check_in']),
      checkOut: DateTime.parse(json['check_out']),
      guests: json['guests'],
      rooms: json['rooms'],
      totalPrice: json['total_price'].toDouble(),
      currency: json['currency'],
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['payment_status'],
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.toString().split('.').last == json['payment_method'],
      ),
      transactionId: json['transaction_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'hotel': hotel.toJson(),
      'check_in': checkIn.toIso8601String(),
      'check_out': checkOut.toIso8601String(),
      'guests': guests,
      'rooms': rooms,
      'total_price': totalPrice,
      'currency': currency,
      'status': status.toString().split('.').last,
      'payment_status': paymentStatus.toString().split('.').last,
      'payment_method': paymentMethod.toString().split('.').last,
      'transaction_id': transactionId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  int get numberOfNights {
    return checkOut.difference(checkIn).inDays;
  }

  Booking copyWith({
    String? id,
    User? user,
    Hotel? hotel,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
    int? rooms,
    double? totalPrice,
    String? currency,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    PaymentMethod? paymentMethod,
    String? transactionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      user: user ?? this.user,
      hotel: hotel ?? this.hotel,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      guests: guests ?? this.guests,
      rooms: rooms ?? this.rooms,
      totalPrice: totalPrice ?? this.totalPrice,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}