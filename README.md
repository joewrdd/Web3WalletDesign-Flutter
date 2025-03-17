# Wrdd Wallet

A modern Flutter-based cryptocurrency wallet that provides a secure and intuitive interface for managing digital assets, NFTs, and transactions on the Ethereum network.

## Features

💰 **Asset Management**

- Multi-token support (ETH, BTC, ADA, SOL, etc.)
- Real-time balance updates
- Token price tracking
- 24h price change indicators
- Detailed token statistics

🎨 **NFT Gallery**

- Visual NFT display
- Collection organization
- Floor price tracking
- NFT metadata viewing
- Grid layout display

💳 **Transaction Features**

- Send/receive tokens
- Transaction history
- Status tracking
- Gas fee estimation
- Multiple transaction types (send, receive, swap, stake)

🔒 **Security**

- Mnemonic phrase generation
- Secure wallet import
- Private key encryption
- Biometric authentication
- Secure storage

🎨 **Design Elements**

- Dark theme
- Gradient backgrounds
- Custom card designs
- Responsive layouts
- Smooth animations

## Technical Stack

### Frontend

- Flutter for cross-platform development
- Provider for state management
- Custom UI components
- Shared preferences for local storage
- Web3dart for blockchain interactions

### Backend

- Flask server
- Moralis API integration
- Ethereum RPC connections
- Transaction processing
- Balance tracking

## Getting Started

### Prerequisites

- Flutter (latest version)
- Python 3.8+
- Moralis API key
- Ethereum node access
- Git

### Installation

1. Clone the repository

```bash
git clone https://github.com/yourusername/wrdd_wallet.git
```

2. Install Flutter dependencies

```bash
cd wrdd_wallet
flutter pub get
```

3. Set up backend

```bash
cd backend
pip install -r requirements.txt
```

4. Configure environment variables

- Create .env file
- Add Moralis API key
- Set Backend URL
- Configure Ethereum RPC endpoint

5. Run the app

```bash
flutter run
```

## Project Structure

```
lib/
├── components/         # Reusable UI components
├── models/            # Data models
├── pages/            # Screen implementations
├── providers/        # State management
├── services/         # Business logic
├── theme/           # UI theme configuration
└── utils/           # Helper functions

backend/
├── app.py           # Flask server
└── requirements.txt # Python dependencies
```

## Features in Detail

### Wallet Features

- Secure key generation
- Multiple token support
- Real-time balance updates
- Transaction management
- Price tracking

### NFT Features

- Gallery view
- Collection management
- Metadata display
- Floor price tracking
- Grid layout

### Transaction Features

- Send/receive tokens
- Transaction history
- Status tracking
- Gas estimation
- Multiple types support

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
