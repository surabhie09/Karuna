# Firebase Integration - TODO

- [x] Add Firebase dependencies (firebase_core, firebase_auth, cloud_firestore) to pubspec.yaml
- [x] Add Google Services classpath to android/build.gradle.kts
- [x] Apply Google Services plugin in android/app/build.gradle.kts
- [x] Initialize Firebase in lib/main.dart
- [x] Run flutter pub get to install dependencies
- [x] Create Firebase service classes (AuthService, FirestoreService)
- [x] Update models.dart to define Firestore-compatible models
- [x] Modify signup_screen.dart and login_screen.dart to use Firebase Auth
- [ ] Update home_content.dart to fetch NGOs from Firestore
- [ ] Implement pledge creation, acceptance, status updates in relevant screens
- [ ] Add filtering logic in search_screen.dart using Firestore queries
- [ ] Handle user sessions and navigation based on auth state
- [ ] Test authentication and data flows
- [ ] Ensure pledge statuses are managed correctly (pending -> ongoing -> completed)
- [ ] Store all data in Firestore except testimonials
