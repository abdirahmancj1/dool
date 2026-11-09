import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EdahabScreen extends StatelessWidget {
  final String merchantNumber = '633730397';

  Future<void> _makeCall(BuildContext context, String code) async {
    final encoded = Uri.encodeComponent(code);
    final url = 'tel:$encoded';
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma suurtagelin furista dialer-ka: $e')),
        );
      }
    }
  }

  Widget _optionCard(BuildContext context, String title, String subtitle, String code, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF97316).withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFF97316), size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            const SizedBox(height: 4),
            Text(
              code,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Color(0xFFF97316),
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFF97316),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.call, color: Colors.white, size: 18),
        ),
        onTap: () => _makeCall(context, code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Adeega eDahab'),
        backgroundColor: const Color(0xFFEA580C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEA580C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFEA580C)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Adeegga eDahab ee Atoore Exchange. Guji nooca aad rabto si aad toos ugu wacdo USSD.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9A3412)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _optionCard(
              context,
              'Sarrifo Dollar (eDahab)',
              'USSD toos ah oo Dollar u sarifaya Shilin',
              '*109*$merchantNumber*1#',
              Icons.attach_money,
            ),
            _optionCard(
              context,
              'Sarrifo Shilling (eDahab)',
              'USSD toos ah oo Shilin u sarifaya Dollar',
              '*119*$merchantNumber*2#',
              Icons.currency_exchange,
            ),
          ],
        ),
      ),
    );
  }
}
