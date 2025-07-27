<p align="center>![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Build](https://github.com/derksKCodes/gemdoc-ai-medical-chatbot-assisant/actions/workflows/flutter.yml/badge.svg)
![Google AI](https://img.shields.io/badge/Google%20AI-4285F4?style=for-the-badge&logo=google&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)
</p>

# 🩺 GemDoc – Your AI Health Expert Powered by Gemini

**GemDoc** is a specialized **AI-powered medical chatbot** built with **Flutter** and integrated with **Google's Gemini API**. In today’s digital era, accessible and accurate health information is essential—and GemDoc aims to deliver exactly that through a reliable, intelligent, and user-friendly experience.

---

## 📑 Table of Contents
- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [Medical Disclaimer](#-medical-disclaimer)
- [Deployment](#-deployment)
- [Roadmap](#-roadmap)
- [Support](#-support)
- [License](#-license)
- [Acknowledgments](#-acknowledgments)

---

## 💡 Overview

GemDoc acts as your trusted digital health assistant, offering personalized and insightful health-related responses powered by advanced AI. Whether you're seeking information about symptoms, health tips, or medical conditions, **GemDoc provides consistent and reliable answers**—right at your fingertips.

---

## 🌟 Features

### Multi-Modal Input Support
- **💬 Text Chat**: Traditional text-based conversations
- **🎤 Voice Input**: Speech-to-text for hands-free interaction
- **📷 Camera Integration**: Real-time image capture for visual symptoms
- **📁 File Upload**: Support for medical documents and reports
- **🖼️ Gallery Access**: Upload images from device gallery

### AI-Powered Healthcare Assistance
- **🎯 Specialized Medical Focus**: Strictly confined to health-related queries
- **🧠 Gemini AI Integration**: Powered by Google's advanced language model
- **📊 Intelligent Response**: Context-aware medical information
- **🔒 Privacy-First**: Secure handling of sensitive health data

### User Experience
- **📱 Cross-Platform**: Available on both iOS and Android
- **🎨 Modern UI/UX**: Clean, intuitive interface designed for healthcare
- **♿ Accessibility**: Built with accessibility standards in mind
- **🌙 Dark/Light Mode**: Comfortable viewing in any environment

---

## 🛠️ Tech Stack

| Layer         | Technology                |
|---------------|----------------------------|
| Frontend      | Flutter                    |
| AI Backend    | Google Gemini API          |
| Audio Input   | Flutter Sound / Speech SDK |
| Image Support | Image Picker, Camera       |
| File Handling | Flutter File Picker        |

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.0 or higher)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/derksKCodes/gemdoc-ai-medical-chatbot-assisant.git
   cd gemdoc-ai-medical-chatbot-assisant
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Google Gemini API**
   - Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key
   - Create a `.env` file in the root directory:
   ```env
   GEMINI_API_KEY=api_key_here
   ```

4. **Configure permissions**
   
   **Android** (`android/app/src/main/AndroidManifest.xml`):
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   ```

   **iOS** (`ios/Runner/Info.plist`):
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>This app needs camera access to capture medical images</string>
   <key>NSMicrophoneUsageDescription</key>
   <string>This app needs microphone access for voice input</string>
   <key>NSPhotoLibraryUsageDescription</key>
   <string>This app needs photo library access to upload medical images</string>
   ```

5. **Run the application**
   ```bash
   flutter run
   ```
   
---

## 📸 Screenshots

> *Coming soon – app UI in action!*

---

## 🏗️ Project Structure

```
gemdoc/
├── android/                   # Android-specific files
├── ios/                       # iOS-specific files
├── lib/                       # Main application code
│   ├── main.dart              # App entry point
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_styles.dart
│   │   │   └── app_strings.dart
│   │   ├── services/
│   │   │   ├── firebase_service.dart
│   │   │   ├── gemini_service.dart
│   │   │   └── notification_service.dart
│   │   ├── utils/
│   │   │   ├── helpers.dart
│   │   │   └── validators.dart
│   │   └── widgets/
│   │       ├── custom_text_field.dart
│   │       ├── health_tips_carousel.dart
│   │       ├── loading_indicator.dart
│   │       └── setting_tile.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── auth_screen.dart
│   │   │   └── widgets/
│   │   │       ├── login_form.dart
│   │   │       └── register_form.dart
│   │   ├── chat/
│   │   │   ├── chat_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── chat_bubble.dart
│   │   │   │   └── message_input.dart
│   │   │   └── models/
│   │   │       └── chat_message.dart
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│   │   │   └── widgets/
│   │   │       └── profile_header.dart
│   │   ├── symptom_checker/
│   │   │   ├── symptom_checker_screen.dart
│   │   │   └── widgets/
│   │   │       └── symptom_chip.dart
│   │   └── onboarding/
│   │       ├── onboarding_screen.dart
│   │       └── widgets/
│   │           └── onboarding_page.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── symptom_model.dart
│   └── state/
│       ├── auth_provider.dart
│       ├── chat_provider.dart
│       ├── theme_provider.dart
│       └── symptom_provider.dart
├── test/                      # Test files
│   ├── widget_test.dart
│   └── mocks/
│       └── mock_services.dart
├── assets/
│   ├── images/                # App images
│   │   ├── logo.png
│   │   ├── doctor.png
│   │   ├── symptoms.png
│   │   └── privacy.png
│   ├── illustrations/         # Custom illustrations
│   └── fonts/                 # Custom fonts
├── web/                       # Web-specific files
├── .env                       # Environment variables
├── .gitignore
├── pubspec.yaml               # Dependencies and assets
├── README.md
├── LICENSE
└── firebase_options.dart      # Firebase configuration
```

---

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
# Google Gemini API
GEMINI_API_KEY=gemini_api_key

# App Configuration
APP_NAME=GemDoc - Medical Chatbot
APP_VERSION=1.0.0
```

### Gemini API Setup

1. Visit [Google AI Studio](https://makersuite.google.com/)
2. Create a new project or select an existing one
3. Enable the Gemini API
4. Generate an API key
5. Add the API key to your `.env` file

## 📱 Usage

### Starting a Conversation
1. Launch the app
2. Choose your preferred input method:
   - Type your health question
   - Tap the microphone for voice input
   - Use the camera to capture symptoms
   - Upload files or images from gallery

### Input Modalities

#### Text Input
- Type your medical questions directly
- Supports multiple languages
- Auto-suggestions for common queries

#### Voice Input
- Tap and hold the microphone button
- Speak your question clearly
- Automatic speech-to-text conversion

#### Image Input
- **Camera**: Capture real-time images of symptoms
- **Gallery**: Upload existing medical images
- **Files**: Support for PDF reports and documents

### Sample Interactions

```
User: "I have a persistent headache for 3 days. What could be the cause?"

Bot: "Persistent headaches can have various causes including:
- Tension headaches from stress or poor posture
- Dehydration
- Sleep deprivation
- Eye strain
- Sinus congestion

However, if your headache persists for more than 3 days or is severe, 
I recommend consulting with a healthcare professional for proper evaluation."
```

---

## 🛡️ Medical Disclaimer

**IMPORTANT**: This chatbot is designed for informational purposes only and should not replace professional medical advice, diagnosis, or treatment. Always consult with qualified healthcare professionals for medical concerns.

### Limitations
- Not a substitute for professional medical consultation
- Cannot provide emergency medical assistance
- Responses are based on general medical knowledge
- Individual cases may vary significantly

---

## 🚀 Deployment

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 📋 Roadmap

- [ ] **Multi-language Support**: Support for additional languages
- [ ] **Offline Mode**: Basic functionality without internet
- [ ] **Health Tracking**: Integration with health monitoring devices
- [ ] **Appointment Booking**: Connect with healthcare providers
- [ ] **Medication Reminders**: Smart reminder system
- [ ] **Symptom Tracker**: Visual symptom tracking over time

---

## 🐛 Known Issues

- Voice input may have accuracy issues in noisy environments
- Large file uploads may take time depending on network speed
- Camera functionality requires proper lighting for best results

---

## 📞 Support

For support and questions:
- 📧 Email: support@medicalchatbot.com
- 🐛 Issues: [GitHub Issues](https://github.com/derksKCodes/medical-chatbot-flutter/issues)
* **Developer:** [@derksKCodes](https://github.com/derksKCodes)
* **Project Link:** [https://github.com/derksKCodes/chefgem-ai-cooking-assistant.git](https://github.com/derksKCodes/gemdoc-ai-medical-chatbot-assisant.git)
  
---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Google Gemini API](https://ai.google.dev/) for AI capabilities
- [Flutter Team](https://flutter.dev/) for the amazing framework
- Medical professionals who provided guidance on healthcare accuracy
- Open source community for various packages and tools

---

## 📊 Statistics

![GitHub stars](https://img.shields.io/github/stars/yourusername/medical-chatbot-flutter)
![GitHub forks](https://img.shields.io/github/forks/yourusername/medical-chatbot-flutter)
![GitHub issues](https://img.shields.io/github/issues/yourusername/medical-chatbot-flutter)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yourusername/medical-chatbot-flutter)

---

**Made with ❤️ for better healthcare accessibility**

*Remember: This tool is designed to supplement, not replace, professional medical advice.*
```

