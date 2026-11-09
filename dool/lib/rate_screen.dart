import 'package:flutter/material.dart';

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String input = '';
  double result = 0;

  final double gacantaHoreRate = 10000;
  final double gacantaDambeRate = 10100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get currentRate => _tabController.index == 0 ? gacantaHoreRate : gacantaDambeRate;

  void _onKeyPress(String key) {
    setState(() {
      if (key == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (key == 'C') {
        input = '';
      } else {
        if (key == '.' && input.contains('.')) return;
        if (input.length < 8) input += key;
      }

      final double? dollar = double.tryParse(input);
      if (dollar != null) {
        result = dollar * currentRate;
      } else {
        result = 0;
      }
    });
  }

  Widget _buildKey(String text) {
    final isAction = text == '⌫' || text == 'C';
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: isAction ? const Color(0xFFF1F5F9) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          elevation: isAction ? 0 : 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _onKeyPress(text),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              child: text == '⌫'
                  ? const Icon(Icons.backspace_outlined, size: 22, color: Color(0xFF475569))
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: isAction ? const Color(0xFF64748B) : const Color(0xFF1E293B),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '⌫'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Xisaabiyaha Qiimaha (Rates)'),
        backgroundColor: const Color(0xFF0F4C81),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: const Color(0xFF00E676),
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'GACANTA HORE'),
            Tab(text: 'GACANTA DAMBE'),
          ],
          onTap: (_) => setState(() {
            final double? dollar = double.tryParse(input);
            result = (dollar != null) ? dollar * currentRate : 0;
          }),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
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
                            color: const Color(0xFF0F4C81).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Xaddiga Dollar (\$)',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            input.isEmpty ? '\$0' : '\$$input',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Divider(color: Colors.white24, height: 24),
                          const Text(
                            'Natiijada Shilin Somaliland (SLSH)',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${result.toStringAsFixed(0)} SLSH',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00E676),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _tabController.index == 0
                                ? 'Heerka: \$1 = 10,000 SLSH (Gacanta Hore)'
                                : 'Heerka: \$1 = 10,100 SLSH (Gacanta Dambe)',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: keys
                    .map((row) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: row.map((key) => _buildKey(key)).toList(),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
