import java.util.Properties
import java.io.FileInputStream

// 1. Load the keystore properties safely
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.well_task_app"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.well_task_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        multiDexEnabled = true
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 2. Define Signing Configs BEFORE Build Types
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            
            // Handle the file path safely
            val storeFileVal = keystoreProperties.getProperty("storeFile")
            if (storeFileVal != null) {
                storeFile = file(storeFileVal)
            }
            
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    buildTypes {
        getByName("release") {
            // 3. Correctly reference the signing config
            signingConfig = signingConfigs.getByName("release")
            // 4. Use 'is' prefix for boolean properties
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    
    // Force specific version of androidx.activity to avoid AGP 8.9.1 requirement
    val activityVersion = "1.9.3"
    implementation("androidx.activity:activity:$activityVersion")
    implementation("androidx.activity:activity-ktx:$activityVersion")
}

configurations.all {
    resolutionStrategy {
        force("androidx.activity:activity:1.9.3")
    }
}