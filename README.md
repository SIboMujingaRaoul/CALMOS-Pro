# CALMOS Flutter V1

Prototype Android/Flutter compilable.

## Ce qui est inclus
- Tableau de bord
- Professeur IA simulé
- Scanner/OCR simulé
- Mode « J'ai été absent »
- Programmes scolaires par pays (structure V1)
- Exercices et progression
- Langues prévues : français, anglais, espagnol, portugais, arabe, haoussa, bambara
- Abonnements et moyens de paiement : ILLICOCASH, M-Pesa, Orange Money, RAWBANK, Visa/Mastercard

## Compilation Android
1. Installer Flutter stable + Android Studio/SDK.
2. Dans ce dossier :
   flutter create . --platforms=android
   flutter pub get
   flutter run
3. Pour un APK :
   flutter build apk --release
4. Pour Google Play :
   flutter build appbundle --release

IMPORTANT : ce prototype ne contient pas de clé API, secret bancaire ou confirmation de paiement côté client.
Les paiements réels, l'IA, l'OCR et les programmes scolaires officiels doivent être reliés à un backend sécurisé.
