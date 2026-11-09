import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectCallService {
  static const MethodChannel _channel = MethodChannel('com.atoore.exchange/call');

  /// Directly dials the USSD / phone number automatically without opening the dialer screen.
  static Future<bool> makeDirectCall(String code) async {
    try {
      final bool? success = await _channel.invokeMethod<bool>('directCall', {'number': code});
      if (success == true) return true;
    } catch (_) {
      // Fallback to url_launcher if MethodChannel is not available (e.g. testing)
    }

    // Fallback:
    try {
      final url = 'tel:${Uri.encodeComponent(code)}';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      }
    } catch (_) {}

    return false;
  }
}

