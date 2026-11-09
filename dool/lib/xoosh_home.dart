import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sarrifo_dollar_screen.dart';
import 'sarrifo_shilling_screen.dart';

class XooshHomePage extends StatelessWidget {
  final String phoneNumber = '0633730397';
  final String whatsappNumber = '252633730397';
  final String whatsappMessage = 'Asc, Waxaan doonayaa inaan la hadlo sariflaha ATOORE Exchange.';

  Future<void> _makeCall() async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(whatsappMessage)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atoore Money Exchange'),
        backgroundColor: const Color(0xFF0F4C81),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SarrifoDollarScreen())),
              child: const Text('Sarrifo Dollar (*377*300212*amount#)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SarrifoShillingScreen())),
              child: const Text('Sarrifo Shilling (*277*300212*amount#)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _makeCall,
              icon: const Icon(Icons.call),
              label: Text('Wac: $phoneNumber'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _openWhatsApp,
              icon: const Icon(Icons.chat),
              label: const Text('WhatsApp Support'),
            ),
          ],
        ),
      ),
    );
  }
}
