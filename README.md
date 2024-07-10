## Let's Test - Advanced Flutter Quiz App

This is a full-featured Flutter quiz application that allows users to:

* **Login and Signup:** Register or login with an existing account.
* **Create Quizzes:** Design new quizzes with questions and answer choices.
* **Edit Quizzes:** Modify existing quizzes you created.
* **Delete Quizzes:** Remove quizzes you don't need anymore.
* **Take Quizzes:** Answer questions and receive feedback on your answers.
* **Track Results:** View your past quiz performance and scores.

**Backend:**

This app utilizes Firebase for user authentication and data storage.

**Getting Started:**

1. **Prerequisites:**
* You'll need Flutter installed on your development machine. Follow the official guide: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
* Create a Firebase project and configure it for your app: [https://firebase.google.com/docs/](https://firebase.google.com/docs/)
2. **Clone the repository:**
   ```bash
   git clone https://github.com/ontu001/letstest-quiz-app-flutter quizapp
    cd letstest-quiz-app-flutter
    flutter run
   ```
3. **Configure Firebase:**
* Create a `firebase_options.dart` file in your project's root directory with your Firebase project configuration (obtained from the Firebase console).
* Follow the instructions provided by Firebase for integrating it into your Flutter app.
4. **Run the app:**
    * Navigate to the project directory in your terminal.
    * Run `flutter pub get` to install dependencies.
    * Run `flutter run` to start the app on a connected device or emulator.

**Dependencies:**

* cloud_firestore: For interacting with a Firebase Firestore database.
* firebase_auth: For user authentication with Firebase.
* flutter: The core Flutter framework.
    * Additional packages might be required based on specific UI implementation.

**Code Structure:**

* `lib/models/`: Contains model classes for user data, quiz data, and question data.
* `lib/services/`: Handles interactions with Firebase Firestore and authentication.
* `lib/screens/`: Contains screens for login, signup, quiz creation, edit, delete, taking quizzes, and viewing results.
* `lib/widgets/`: Reusable UI components for displaying quiz options, creating questions, etc.
