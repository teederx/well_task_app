@echo off
cd /d %~dp0
echo Cleaning project...
flutter clean

echo Getting dependencies...
flutter pub get

echo Building APK...
flutter build apk --release

echo.
echo ======= DONE =======
echo APK is located at: build\app\outputs\flutter-apk\app-release.apk
pause