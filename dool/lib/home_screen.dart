import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'rate_screen.dart';
import 'sarrifo_dollar_screen.dart';
import 'sarrifo_shilling_screen.dart';
import 'edahab_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.atoore.exchange';
  final String phoneNumber = '0633730397';
  final String whatsappNumber = '252633730397';
  final String whatsappMessage =
      'Asc, Waxaan doonayaa inaan la hadlo sariflaha ATOORE Exchange.';

  int _selectedIndex = 0;

  Future<void> _makePhoneCall(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ma suurtagelin wicitaanka: $e')),
        );
      }
    }
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(
        'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(whatsappMessage)}');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp laguma furin karo qalabkan.')),
        );
      }
    }
  }

  void _shareApp() {
    Share.share(
      '📲 Soo degso ATOORE Exchange App!\nAdeeg sarifeed degdeg ah oo la aamini karo.\nKala xidhiidh: 063-3730397\nLink: $playStoreUrl',
      subject: 'Atoore Money Exchange',
    );
  }

  Future<void> _handleMenuAction(BuildContext context, String value) async {
    if (value == 'Rate garee Appka') {
      final uri = Uri.parse(playStoreUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else if (value == 'Lahadal Sariflaha') {
      await _makePhoneCall(phoneNumber);
    } else if (value == 'WhatsApp') {
      await _openWhatsApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F4C81),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.currency_exchange, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text(
              'Atoore Exchange',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            tooltip: 'Wadaag App-ka',
            onPressed: _shareApp,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) => _handleMenuAction(context, value),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Rate garee Appka',
                child: Row(
                  children: [
                    Icon(Icons.star_rate, color: Colors.amber, size: 20),
                    SizedBox(width: 10),
                    Text('Rate garee Appka'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Lahadal Sariflaha',
                child: Row(
                  children: [
                    Icon(Icons.call, color: Color(0xFF0F4C81), size: 20),
                    SizedBox(width: 10),
                    Text('Lahadal Sariflaha'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'WhatsApp',
                child: Row(
                  children: [
                    Icon(Icons.chat, color: Color(0xFF00A86B), size: 20),
                    SizedBox(width: 10),
                    Text('WhatsApp Support'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Modern Header Card
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F4C81), Color(0xFF1E3A8A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
              child: Column(
                children: [
                  // Merchant ID Pill & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_user, color: Color(0xFF00E676), size: 14),
                            SizedBox(width: 6),
                            Text(
                              'Aqoonsiga: 300212',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E676).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Adeeg 24/7 Furan',
                          style: TextStyle(
                            color: Color(0xFF00E676),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Today's Exchange Rate Display Card
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _rateColumn('GACANTA HORE', '\$1 = 10,000 SLSH'),
                        Container(width: 1, height: 36, color: Colors.white24),
                        _rateColumn('GACANTA DAMBE', '\$1 = 10,100 SLSH'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Services Quick Row (ZAAD, eDahab, Rate, About)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _quickServiceItem('ZAAD', 'assets/images/zaad.png', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => SarrifoDollarScreen()));
                      }),
                      _quickServiceItem('eDahab', 'assets/images/edahab.png', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EdahabScreen()));
                      }),
                      _quickServiceItem('Rate', 'assets/images/rate.png', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RateScreen()));
                      }),
                      _quickServiceItem('About', 'assets/images/iconn.jpg', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AboutScreen()));
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Main Action Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F4C81),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Dooro Nooca Sarifka',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Two Hero Action Cards (Sarrifo Dollar & Sarrifo Shilling)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _modernExchangeCard(
                    title: 'Sarrifo Dollar (\$)',
                    subtitle: 'Dollar u bedel Shilin Somaliland',
                    ussdHint: '*377*300212*amount#',
                    color1: const Color(0xFF0F4C81),
                    color2: const Color(0xFF1E3A8A),
                    icon: Icons.attach_money,
                    badgeText: 'Dollar -> Shilin',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SarrifoDollarScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _modernExchangeCard(
                    title: 'Sarrifo Shilling (SLSH)',
                    subtitle: 'Shilin Somaliland u bedel Dollar',
                    ussdHint: '*277*300212*amount#',
                    color1: const Color(0xFF00875A),
                    color2: const Color(0xFF005A36),
                    icon: Icons.currency_exchange,
                    badgeText: 'Shilin -> Dollar',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SarrifoShillingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Customer Support Card with 0633730397
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F4C81).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.support_agent, color: Color(0xFF0F4C81), size: 26),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ma u baahan tahay Caawimaad?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Toos ula xidhiidh sariflaha ATOORE',
                                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _makePhoneCall(phoneNumber),
                            icon: const Icon(Icons.call, size: 18, color: Colors.white),
                            label: const Text(
                              '063-3730397',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F4C81),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _openWhatsApp,
                            icon: const Icon(Icons.chat, size: 18, color: Colors.white),
                            label: const Text(
                              'WhatsApp',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A86B),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF0F4C81),
          unselectedItemColor: const Color(0xFF94A3B8),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
            if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AboutScreen()));
            } else if (index == 2) {
              _shareApp();
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About'),
            BottomNavigationBarItem(icon: Icon(Icons.share_outlined), label: 'Share App'),
          ],
        ),
      ),
    );
  }

  Widget _rateColumn(String label, String rate) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          rate,
          style: const TextStyle(color: Color(0xFF00E676), fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _quickServiceItem(String title, String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernExchangeCard({
    required String title,
    required String subtitle,
    required String ussdHint,
    required Color color1,
    required Color color2,
    required IconData icon,
    required String badgeText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          badgeText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.dialpad, color: Color(0xFF00E676), size: 14),
                      const SizedBox(width: 5),
                      Text(
                        ussdHint,
                        style: const TextStyle(
                          color: Color(0xFF00E676),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F4C81), Color(0xFF1E3A8A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.currency_exchange, color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'ATOORE EXCHANGE',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Aqoonsi: 300212 | 063-3730397',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Color(0xFF0F4C81)),
            title: const Text('Sarrifo Dollar (*377*300212*amount#)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => SarrifoDollarScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange, color: Color(0xFF00875A)),
            title: const Text('Sarrifo Shilling (*277*300212*amount#)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => SarrifoShillingScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up, color: Colors.amber),
            title: const Text('Qiimaha Sarifka (Rates)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => RateScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.call, color: Color(0xFF0F4C81)),
            title: const Text('Wac Sariflaha: 063-3730397'),
            onTap: () {
              Navigator.pop(context);
              _makePhoneCall(phoneNumber);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: Color(0xFF00A86B)),
            title: const Text('WhatsApp: +252 63 3730397'),
            onTap: () {
              Navigator.pop(context);
              _openWhatsApp();
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.grey),
            title: const Text('Ku Saabsan Atoore Exchange'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
