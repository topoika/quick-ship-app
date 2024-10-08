# Preserve all Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Preserve image_picker classes
-keep class io.flutter.plugins.imagepicker.** { *; }

# Preserve classes for Firebase plugins
-keep class io.flutter.plugins.firebase.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Preserve classes for lifecycle and other common Android libraries
-keep class androidx.lifecycle.** { *; }
-keep class androidx.annotation.** { *; }

# Add rules for any other dependencies as needed
