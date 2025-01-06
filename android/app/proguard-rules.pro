# Firebase Core
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**
-keep class io.flutter.plugins.firebase.messaging.** { *; }

# FCM 서비스 보호
-keep class com.google.firebase.messaging.FirebaseMessagingService { *; }

# FCM Custom Sound (선택적 기능)
-keep class com.google.firebase.messaging.RemoteMessage { *; }
-keep class com.google.firebase.messaging.RemoteMessage$Notification { *; }
-keepclassmembers class com.google.firebase.messaging.RemoteMessage$Notification {
    public java.lang.String getSound();
}

# Flutter-specific rules
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Gson (Flutter가 사용하는 경우)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**

# 앱의 패키지 이름 (사용 중인 패키지로 변경)
-keep class com.daily.step.dailystep.** { *; }

