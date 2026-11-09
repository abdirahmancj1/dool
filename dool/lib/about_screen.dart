import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final String phoneNumber = '0633730397';
  final String whatsappNumber = '252633730397';

  Future<void> _callPhone(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma suurtagelin wicitaanka: $e')),
        );
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent("Asc, Waxaan doonayaa inaan la hadlo sariflaha ATOORE Exchange.")}',
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp laguma furin karo qalabkan.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Ku Saabsan Atoore Exchange'),
        backgroundColor: const Color(0xFF0F4C81),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F4C81), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F4C81).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.currency_exchange, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'ATOORE MONEY EXCHANGE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Merchant ID: 300212 | Hargeysa, Somaliland',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adeeg Casri ah oo Degdeg ah',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Atoore Money Exchange waa adeeg casri ah oo kuu fududeynaya sarifka lacagaha Dollar iyo Shilin Somaliland adigoo isticmaalaya adeegga ZAAD.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.5),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Hababka Tooska ah ee USSD:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('• Sarrifo Dollar (Dollar -> Shilin): *377*300212*amount#',
                      style: TextStyle(fontSize: 13, color: Color(0xFF0F4C81), fontWeight: FontWeight.w600)),
                  SizedBox(height: 6),
                  Text('• Sarrifo Shilin (Shilin -> Dollar): *277*300212*amount#',
                      style: TextStyle(fontSize: 13, color: Color(0xFF00875A), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contact Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Xidhiidhka Tooska ah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 14),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFF1F5F9),
                      child: Icon(Icons.phone, color: Color(0xFF0F4C81)),
                    ),
                    title: const Text('Taleefanka', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    subtitle: const Text('063-3730397', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    trailing: ElevatedButton(
                      onPressed: () => _callPhone(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F4C81),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Wac', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const Divider(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFECFDF5),
                      child: Icon(Icons.chat, color: Color(0xFF00A86B)),
                    ),
                    title: const Text('WhatsApp', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    subtitle: const Text('+252 63 3730397', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    trailing: ElevatedButton(
                      onPressed: () => _openWhatsApp(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Chat', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: Text(
                'Version 2.0.0\n© 2026 Atoore Exchange. Xuquuqda oo dhan way dhowran tahay.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
