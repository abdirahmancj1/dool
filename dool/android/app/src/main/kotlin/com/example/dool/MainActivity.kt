package com.example.dool

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.atoore.exchange/call"
    private val CALL_PERMISSION_REQUEST_CODE = 1001
    private var pendingNumber: String? = null
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "directCall") {
                val number = call.argument<String>("number")
                if (number.isNullOrEmpty()) {
                    result.error("INVALID_NUMBER", "Number is empty", null)
                    return@setMethodCallHandler
                }

                if (ContextCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED) {
                    performDirectCall(number)
                    result.success(true)
                } else {
                    pendingNumber = number
                    pendingResult = result
                    ActivityCompat.requestPermissions(
                        this,
                        arrayOf(Manifest.permission.CALL_PHONE),
                        CALL_PERMISSION_REQUEST_CODE
                    )
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun performDirectCall(number: String) {
        val encoded = Uri.encode(number)
        val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:$encoded"))
        try {
            startActivity(intent)
        } catch (e: Exception) {
            val dialIntent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:$encoded"))
            startActivity(dialIntent)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == CALL_PERMISSION_REQUEST_CODE) {
            val number = pendingNumber
            val result = pendingResult
            pendingNumber = null
            pendingResult = null

            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                if (number != null) {
                    performDirectCall(number)
                    result?.success(true)
                }
            } else {
                if (number != null) {
                    val encoded = Uri.encode(number)
                    val dialIntent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:$encoded"))
                    startActivity(dialIntent)
                }
                result?.success(false)
            }
        }
    }
}
