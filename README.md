# StayEasy - Hotel Booking Website

A modern, responsive hotel booking website with integrated UPI payment system. Built with vanilla HTML, CSS, and JavaScript for optimal performance and compatibility.

## Features

### 🏨 Hotel Booking
- Search hotels by destination, dates, and guest count
- Featured hotels from popular Indian destinations
- Detailed hotel information with ratings and amenities
- Real-time availability and pricing

### 💳 UPI Payment Integration
- Support for all major UPI apps (Google Pay, PhonePe, Paytm)
- QR code generation for seamless payments
- Secure payment processing
- Instant booking confirmation

### 📱 Modern UI/UX
- Responsive design for all devices
- Beautiful gradient backgrounds
- Smooth animations and transitions
- Mobile-first approach
- Accessible design with proper contrast and typography

### 🔧 Technical Features
- Vanilla JavaScript (no frameworks)
- CSS Grid and Flexbox layouts
- Font Awesome icons
- Google Fonts integration
- Local data storage
- Form validation
- Modal dialogs

## Quick Start

1. Open `index.html` in any modern web browser
2. Search for hotels using the search form
3. Browse available hotels and select one to book
4. Fill in guest details and proceed to payment
5. Choose your preferred UPI payment method
6. Complete the booking process

## File Structure

```
/
├── index.html          # Main HTML file
├── styles.css          # CSS styling
├── script.js           # JavaScript functionality
└── README.md           # This file
```

## Supported Destinations

- Mumbai, India
- Goa, India  
- Manali, India
- Jaipur, India
- Delhi, India
- Udaipur, India

## Payment Methods

- Google Pay
- PhonePe
- Paytm
- Any UPI-enabled app
- QR code scanning

## Browser Compatibility

- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+
- Mobile browsers (iOS Safari, Chrome Mobile)

## Development

This is a static website that requires no build process or server setup. Simply open the HTML file in a browser to run the application.

For production deployment:
1. Upload files to any web server
2. Configure HTTPS for secure payments
3. Set up actual UPI payment gateway integration
4. Add backend for booking management

## Customization

### Adding Hotels
Edit the `hotels` array in `script.js` to add new hotels:

```javascript
{
    id: 7,
    name: "Your Hotel Name",
    location: "City, India",
    image: "https://your-image-url.jpg",
    rating: 4.5,
    price: 5999,
    amenities: ["WiFi", "Pool", "Spa"],
    description: "Hotel description"
}
```

### Styling
Modify `styles.css` to customize:
- Colors and themes
- Layout and spacing
- Animations and transitions
- Typography

## Security Notes

- This demo uses simulated payments
- For production, implement proper payment gateway integration
- Add server-side validation and booking management
- Use HTTPS for all payment-related operations
- Implement proper error handling and logging

## License

This project is open source and available under the MIT License.
