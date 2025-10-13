# ProGuard/R8 rules for Flutter + Firebase Core/Auth
# Keep Firebase Auth and Core models/reflection-using classes
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }

# Keep classes with @Keep
-keep @com.google.firebase.firestore.PropertyName class * { *; }
-keep @com.google.android.gms.common.util.DynamiteApi class * { *; }

# Retain parcelables
-keep class * implements android.os.Parcelable { *; }

# Keep flutter plugins registrant
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**
