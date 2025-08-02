// Sample hotel data
const hotels = [
    {
        id: 1,
        name: "Grand Palace Hotel",
        location: "Mumbai, India",
        image: "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=250&fit=crop",
        rating: 4.5,
        price: 5999,
        amenities: ["WiFi", "Pool", "Spa", "Gym"],
        description: "Luxury hotel in the heart of Mumbai with world-class amenities."
    },
    {
        id: 2,
        name: "Coastal Resort",
        location: "Goa, India",
        image: "https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400&h=250&fit=crop",
        rating: 4.2,
        price: 4299,
        amenities: ["Beach Access", "WiFi", "Restaurant", "Bar"],
        description: "Beautiful beachfront resort perfect for a relaxing getaway."
    },
    {
        id: 3,
        name: "Mountain View Lodge",
        location: "Manali, India",
        image: "https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=400&h=250&fit=crop",
        rating: 4.7,
        price: 3899,
        amenities: ["Mountain View", "WiFi", "Fireplace", "Hiking"],
        description: "Cozy lodge with breathtaking mountain views and adventure activities."
    },
    {
        id: 4,
        name: "Heritage Palace",
        location: "Jaipur, India",
        image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=400&h=250&fit=crop",
        rating: 4.6,
        price: 6799,
        amenities: ["Heritage", "WiFi", "Spa", "Cultural Tours"],
        description: "Experience royal heritage in this magnificent palace hotel."
    },
    {
        id: 5,
        name: "Business Hotel Central",
        location: "Delhi, India",
        image: "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400&h=250&fit=crop",
        rating: 4.3,
        price: 4999,
        amenities: ["Business Center", "WiFi", "Conference Rooms", "Airport Shuttle"],
        description: "Modern business hotel with excellent connectivity and amenities."
    },
    {
        id: 6,
        name: "Lake View Resort",
        location: "Udaipur, India",
        image: "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400&h=250&fit=crop",
        rating: 4.8,
        price: 7299,
        amenities: ["Lake View", "WiFi", "Boat Rides", "Spa"],
        description: "Romantic lakeside resort with stunning views and luxury amenities."
    }
];

let selectedHotel = null;
let bookingData = {};

// DOM Elements
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');
const bookingModal = document.getElementById('bookingModal');
const paymentModal = document.getElementById('paymentModal');
const closeBtn = document.querySelector('.close');
const closePaymentBtn = document.querySelector('.close-payment');

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    loadHotels();
    setupEventListeners();
    setDefaultDates();
});

// Set default check-in and check-out dates
function setDefaultDates() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const checkinInput = document.getElementById('checkin');
    const checkoutInput = document.getElementById('checkout');
    
    if (checkinInput) checkinInput.value = today.toISOString().split('T')[0];
    if (checkoutInput) checkoutInput.value = tomorrow.toISOString().split('T')[0];
}

// Setup event listeners
function setupEventListeners() {
    // Mobile menu toggle
    if (hamburger) {
        hamburger.addEventListener('click', () => {
            navMenu.classList.toggle('active');
        });
    }

    // Modal close events
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            bookingModal.style.display = 'none';
        });
    }

    if (closePaymentBtn) {
        closePaymentBtn.addEventListener('click', () => {
            paymentModal.style.display = 'none';
        });
    }

    // Close modals when clicking outside
    window.addEventListener('click', (event) => {
        if (event.target === bookingModal) {
            bookingModal.style.display = 'none';
        }
        if (event.target === paymentModal) {
            paymentModal.style.display = 'none';
        }
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
            // Close mobile menu if open
            navMenu.classList.remove('active');
        });
    });
}

// Load and display hotels
function loadHotels() {
    const hotelsGrid = document.getElementById('hotelsGrid');
    if (!hotelsGrid) return;

    hotelsGrid.innerHTML = '';
    
    hotels.forEach(hotel => {
        const hotelCard = createHotelCard(hotel);
        hotelsGrid.appendChild(hotelCard);
    });
}

// Create hotel card element
function createHotelCard(hotel) {
    const card = document.createElement('div');
    card.className = 'hotel-card';
    
    const stars = '★'.repeat(Math.floor(hotel.rating)) + '☆'.repeat(5 - Math.floor(hotel.rating));
    
    card.innerHTML = `
        <img src="${hotel.image}" alt="${hotel.name}" class="hotel-image" loading="lazy">
        <div class="hotel-info">
            <h3 class="hotel-name">${hotel.name}</h3>
            <p class="hotel-location">
                <i class="fas fa-map-marker-alt"></i>
                ${hotel.location}
            </p>
            <div class="hotel-rating">
                <span class="stars">${stars}</span>
                <span>${hotel.rating}</span>
            </div>
            <div class="hotel-price">
                ₹${hotel.price.toLocaleString('en-IN')} <span>per night</span>
            </div>
            <button class="book-btn" onclick="openBookingModal(${hotel.id})">
                Book Now
            </button>
        </div>
    `;
    
    return card;
}

// Search hotels function
function searchHotels() {
    const destination = document.getElementById('destination').value;
    const checkin = document.getElementById('checkin').value;
    const checkout = document.getElementById('checkout').value;
    const guests = document.getElementById('guests').value;

    if (!destination || !checkin || !checkout) {
        alert('Please fill in all search fields');
        return;
    }

    if (new Date(checkin) >= new Date(checkout)) {
        alert('Check-out date must be after check-in date');
        return;
    }

    // Filter hotels based on destination
    const filteredHotels = hotels.filter(hotel => 
        hotel.location.toLowerCase().includes(destination.toLowerCase())
    );

    const hotelsGrid = document.getElementById('hotelsGrid');
    if (!hotelsGrid) return;

    hotelsGrid.innerHTML = '';
    
    if (filteredHotels.length === 0) {
        hotelsGrid.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; padding: 2rem;">
                <h3>No hotels found for "${destination}"</h3>
                <p>Try searching for Mumbai, Goa, Manali, Jaipur, Delhi, or Udaipur</p>
            </div>
        `;
    } else {
        filteredHotels.forEach(hotel => {
            const hotelCard = createHotelCard(hotel);
            hotelsGrid.appendChild(hotelCard);
        });
    }

    // Scroll to hotels section
    document.getElementById('hotels').scrollIntoView({
        behavior: 'smooth'
    });
}

// Open booking modal
function openBookingModal(hotelId) {
    selectedHotel = hotels.find(hotel => hotel.id === hotelId);
    if (!selectedHotel) return;

    const modalContent = document.getElementById('modalContent');
    const checkin = document.getElementById('checkin').value || new Date().toISOString().split('T')[0];
    const checkout = document.getElementById('checkout').value || new Date(Date.now() + 86400000).toISOString().split('T')[0];
    const guests = document.getElementById('guests').value || '2';

    const nights = Math.ceil((new Date(checkout) - new Date(checkin)) / (1000 * 60 * 60 * 24));
    const totalPrice = selectedHotel.price * nights;

    modalContent.innerHTML = `
        <div class="booking-summary">
            <h3>${selectedHotel.name}</h3>
            <p><i class="fas fa-map-marker-alt"></i> ${selectedHotel.location}</p>
            <p><strong>Check-in:</strong> ${new Date(checkin).toLocaleDateString('en-IN')}</p>
            <p><strong>Check-out:</strong> ${new Date(checkout).toLocaleDateString('en-IN')}</p>
            <p><strong>Guests:</strong> ${guests}</p>
            <p><strong>Nights:</strong> ${nights}</p>
            <p><strong>Price per night:</strong> ₹${selectedHotel.price.toLocaleString('en-IN')}</p>
            <hr>
            <h4><strong>Total Amount: ₹${totalPrice.toLocaleString('en-IN')}</strong></h4>
        </div>
        
        <form class="booking-form" onsubmit="proceedToPayment(event)">
            <h3>Guest Details</h3>
            <input type="text" placeholder="Full Name" required id="guestName">
            <input type="email" placeholder="Email Address" required id="guestEmail">
            <input type="tel" placeholder="Phone Number" required id="guestPhone">
            <textarea placeholder="Special Requests (Optional)" rows="3" id="specialRequests"></textarea>
            
            <button type="submit" class="search-btn" style="margin-top: 1rem;">
                Proceed to Payment
            </button>
        </form>
    `;

    bookingData = {
        hotel: selectedHotel,
        checkin,
        checkout,
        guests,
        nights,
        totalPrice
    };

    bookingModal.style.display = 'block';
}

// Proceed to payment
function proceedToPayment(event) {
    event.preventDefault();
    
    const guestName = document.getElementById('guestName').value;
    const guestEmail = document.getElementById('guestEmail').value;
    const guestPhone = document.getElementById('guestPhone').value;
    const specialRequests = document.getElementById('specialRequests').value;

    if (!guestName || !guestEmail || !guestPhone) {
        alert('Please fill in all required fields');
        return;
    }

    bookingData.guest = {
        name: guestName,
        email: guestEmail,
        phone: guestPhone,
        specialRequests
    };

    bookingModal.style.display = 'none';
    openPaymentModal();
}

// Open payment modal
function openPaymentModal() {
    const paymentContent = document.getElementById('paymentContent');
    
    paymentContent.innerHTML = `
        <div class="booking-summary">
            <h3>Payment Summary</h3>
            <p><strong>Hotel:</strong> ${bookingData.hotel.name}</p>
            <p><strong>Guest:</strong> ${bookingData.guest.name}</p>
            <p><strong>Total Amount:</strong> ₹${bookingData.totalPrice.toLocaleString('en-IN')}</p>
        </div>
        
        <div class="payment-section">
            <h3>Choose UPI Payment Method</h3>
            <div class="upi-options">
                <div class="upi-btn" onclick="selectUPIMethod('googlepay')">
                    <i class="fab fa-google-pay"></i>
                    <span>Google Pay</span>
                </div>
                <div class="upi-btn" onclick="selectUPIMethod('phonepe')">
                    <i class="fas fa-mobile-alt" style="color: #5f259f;"></i>
                    <span>PhonePe</span>
                </div>
                <div class="upi-btn" onclick="selectUPIMethod('paytm')">
                    <i class="fas fa-wallet" style="color: #00baf2;"></i>
                    <span>Paytm</span>
                </div>
                <div class="upi-btn" onclick="selectUPIMethod('upi')">
                    <i class="fas fa-qrcode"></i>
                    <span>UPI QR</span>
                </div>
            </div>
            
            <div id="paymentDetails" style="display: none;">
                <div class="qr-code">
                    <div class="qr-placeholder">
                        <i class="fas fa-qrcode"></i><br>
                        Scan QR Code
                    </div>
                    <p><strong>UPI ID:</strong> stayeasy@upi</p>
                    <p><strong>Amount:</strong> ₹${bookingData.totalPrice.toLocaleString('en-IN')}</p>
                    <p>Scan this QR code with your UPI app to complete the payment</p>
                </div>
                
                <div style="text-align: center;">
                    <button class="search-btn" onclick="simulatePayment()" style="margin: 1rem;">
                        <i class="fas fa-check"></i>
                        Payment Completed
                    </button>
                    <p style="font-size: 0.9rem; color: #666; margin-top: 0.5rem;">
                        Click after completing payment in your UPI app
                    </p>
                </div>
            </div>
        </div>
    `;

    paymentModal.style.display = 'block';
}

// Select UPI payment method
function selectUPIMethod(method) {
    // Remove previous selection
    document.querySelectorAll('.upi-btn').forEach(btn => {
        btn.classList.remove('selected');
    });

    // Add selection to clicked button
    event.target.closest('.upi-btn').classList.add('selected');

    // Show payment details
    const paymentDetails = document.getElementById('paymentDetails');
    paymentDetails.style.display = 'block';

    // Scroll to payment details
    paymentDetails.scrollIntoView({ behavior: 'smooth' });

    // Generate UPI deep link (in real implementation)
    generateUPILink(method);
}

// Generate UPI payment link
function generateUPILink(method) {
    const upiString = `upi://pay?pa=stayeasy@upi&pn=StayEasy Hotels&am=${bookingData.totalPrice}&cu=INR&tn=Hotel Booking ${bookingData.hotel.name}`;
    
    // In a real implementation, you would open the UPI app
    console.log(`UPI Payment Link (${method}):`, upiString);
    
    // For demo purposes, we'll show the QR code placeholder
    // In production, you'd generate an actual QR code here
}

// Simulate payment completion
function simulatePayment() {
    const paymentContent = document.getElementById('paymentContent');
    
    paymentContent.innerHTML = `
        <div class="success-animation">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h2>Payment Successful!</h2>
            <p>Your booking has been confirmed</p>
            
            <div class="booking-summary">
                <h3>Booking Confirmation</h3>
                <p><strong>Booking ID:</strong> STE${Date.now().toString().slice(-6)}</p>
                <p><strong>Hotel:</strong> ${bookingData.hotel.name}</p>
                <p><strong>Guest:</strong> ${bookingData.guest.name}</p>
                <p><strong>Check-in:</strong> ${new Date(bookingData.checkin).toLocaleDateString('en-IN')}</p>
                <p><strong>Check-out:</strong> ${new Date(bookingData.checkout).toLocaleDateString('en-IN')}</p>
                <p><strong>Amount Paid:</strong> ₹${bookingData.totalPrice.toLocaleString('en-IN')}</p>
            </div>
            
            <p style="margin: 2rem 0; color: #666;">
                Confirmation details have been sent to ${bookingData.guest.email}
            </p>
            
            <button class="search-btn" onclick="closePaymentModal()">
                Close
            </button>
        </div>
    `;

    // In real implementation, you would:
    // 1. Send confirmation email
    // 2. Update booking database
    // 3. Generate booking voucher
    // 4. Send SMS confirmation
}

// Close payment modal
function closePaymentModal() {
    paymentModal.style.display = 'none';
    // Reset form for next booking
    selectedHotel = null;
    bookingData = {};
}

// Utility function to format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-IN', {
        style: 'currency',
        currency: 'INR'
    }).format(amount);
}

// Add smooth scrolling animation for search results
function animateSearchResults() {
    const hotelCards = document.querySelectorAll('.hotel-card');
    hotelCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
        card.classList.add('fade-in');
    });
}

// Add CSS animation class dynamically
const style = document.createElement('style');
style.textContent = `
    .fade-in {
        animation: fadeInUp 0.6s ease-out forwards;
        opacity: 0;
        transform: translateY(20px);
    }
    
    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
`;
document.head.appendChild(style);

// Initialize date inputs with proper validation
function initializeDateValidation() {
    const checkinInput = document.getElementById('checkin');
    const checkoutInput = document.getElementById('checkout');
    
    if (checkinInput) {
        checkinInput.addEventListener('change', function() {
            const checkinDate = new Date(this.value);
            const tomorrow = new Date(checkinDate);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            if (checkoutInput) {
                checkoutInput.min = tomorrow.toISOString().split('T')[0];
                if (new Date(checkoutInput.value) <= checkinDate) {
                    checkoutInput.value = tomorrow.toISOString().split('T')[0];
                }
            }
        });
    }
}