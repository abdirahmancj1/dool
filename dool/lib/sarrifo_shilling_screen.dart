import 'package:flutter/material.dart';
import 'direct_call_service.dart';

class SarrifoShillingScreen extends StatefulWidget {
  const SarrifoShillingScreen({super.key});

  @override
  State<SarrifoShillingScreen> createState() => _SarrifoShillingScreenState();
}

class _SarrifoShillingScreenState extends State<SarrifoShillingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String input = '';
  double result = 0;

  final double horeRate = 10000;
  final double dambeRate = 10100;

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

  double get currentRate => _tabController.index == 0 ? horeRate : dambeRate;

  void _onKeyPress(String key) {
    setState(() {
      if (key == '⌫') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (key == 'C') {
        input = '';
      } else if (key == '000') {
        if (input.isNotEmpty && input.length < 10) input += '000';
      } else {
        if (input.length < 12) input += key;
      }

      final sh = double.tryParse(input);
      if (sh != null && currentRate > 0) {
        result = sh / currentRate;
      } else {
        result = 0;
      }
    });
  }

  void _setPresetAmount(String val) {
    setState(() {
      input = val;
      final sh = double.tryParse(input);
      result = (sh != null && currentRate > 0) ? sh / currentRate : 0;
    });
  }

  Future<void> _executeDirectCall(String amount) async {
    final ussd = '*277*300212*$amount#';
    final success = await DirectCallService.makeDirectCall(ussd);
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fadlan ogolow permission-ka wicitaanka taleefanka si toos ah loogu garaaco.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _showConfirmationSheet() {
    final shAmount = input;
    final usdAmount = result.toStringAsFixed(2);
    final ussdCode = '*277*300212*$shAmount#';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A86B).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_in_talk,
                  color: Color(0xFF00A86B),
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Xaqiiji Sarrifka Shilin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Atoore Exchange (Aqoonsi: 300212)',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _sheetRow('Lacagta aad dirayso', '$shAmount SLSH', isHighlight: true),
                    const Divider(height: 20),
                    _sheetRow('Lacagta aad helayso', '\$$usdAmount USD'),
                    const Divider(height: 20),
                    _sheetRow('Qiimaha Sarifka', '1 USD = ${currentRate.toStringAsFixed(0)} SLSH'),
                    const Divider(height: 20),
                    _sheetRow('USSD Code toos u wacaya', ussdCode, isMonospace: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      child: const Text(
                        'Kansal garee',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _executeDirectCall(shAmount);
                      },
                      icon: const Icon(Icons.call, color: Colors.white, size: 20),
                      label: const Text(
                        'Toos u Garaac (Call)',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetRow(String title, String value, {bool isHighlight = false, bool isMonospace = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: isHighlight ? const Color(0xFF00A86B) : const Color(0xFF1E293B),
            fontFamily: isMonospace ? 'monospace' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPresetChip(String label, String amount) {
    final isSelected = input == amount;
    return GestureDetector(
      onTap: () => _setPresetAmount(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00A86B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF00A86B) : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
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
          shadowColor: Colors.black12,
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
                        fontSize: text == '000' ? 18 : 22,
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
      ['000', '0', '⌫'],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Sarrifo Shilling'),
        backgroundColor: const Color(0xFF00875A),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFF00875A),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.amberAccent,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              tabs: const [
                Tab(text: 'GACANTA HORE'),
                Tab(text: 'GACANTA DAMBE'),
              ],
              onTap: (_) => setState(() {
                final sh = double.tryParse(input);
                result = (sh != null && currentRate > 0) ? sh / currentRate : 0;
              }),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  children: [
                    // Rate info pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F4C81).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFF0F4C81).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.currency_exchange, color: Color(0xFF0F4C81), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Qiimaha: \$1 = ${currentRate.toStringAsFixed(0)} SLSH',
                            style: const TextStyle(
                              color: Color(0xFF0F4C81),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Modern Display Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00875A), Color(0xFF005A36)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00875A).withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Gali Lacagta Shilin (SLSH)',
                                style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Atoore: 300212',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              input.isEmpty ? '0 SLSH' : '$input SLSH',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Waxaad helaysaa: ',
                                  style: TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                                Text(
                                  '\$${result.toStringAsFixed(2)} USD',
                                  style: const TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Quick Preset Chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPresetChip('50K', '50000'),
                        _buildPresetChip('100K', '100000'),
                        _buildPresetChip('200K', '200000'),
                        _buildPresetChip('500K', '500000'),
                        _buildPresetChip('1M', '1000000'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Keypad & Bottom Action
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...keys.map((row) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: row.map((key) => _buildKey(key)).toList(),
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: input.isNotEmpty && (double.tryParse(input) ?? 0) > 0
                          ? _showConfirmationSheet
                          : null,
                      icon: const Icon(Icons.phone_forwarded, color: Colors.white),
                      label: Text(
                        input.isEmpty ? 'Gali Qiimaha Shilin' : 'Sarrifo Hadda (*277*300212*$input#)',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00875A),
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
