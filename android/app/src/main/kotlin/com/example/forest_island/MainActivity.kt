package ru.xpage.mobile.forest_island

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("74554065-bb9b-49eb-a8c6-c0ffe3cda2c7")
    super.configureFlutterEngine(flutterEngine)
  }
}
