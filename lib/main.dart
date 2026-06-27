import 'package:flutter/material.dart';

void main() {
  runApp(const LogiSphereApp());
}

class LogiSphereApp extends StatelessWidget {
  const LogiSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogiSphere AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        primaryColor: const Color(0xFF3B82F6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF10B981),
          surface: Color(0xFF1E293B),
        ),
      ),
      home: const MainControlTowerGrid(),
    );
  }
}

class MainControlTowerGrid extends StatefulWidget {
  const MainControlTowerGrid({super.key});

  @override
  State<MainControlTowerGrid> createState() => _MainControlTowerGridState();
}

class _MainControlTowerGridState extends State<MainControlTowerGrid> {
  int _selectedModuleIndex = 0;

  final List<Widget> _views = const [
    ControlTowerDashboardView(),
    Center(child: Text('Module 1: Real-time Shipment Tracking View')),
    Center(child: Text('Module 2: AI Dynamic Route Optimizer')),
    AIAssistantView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedModuleIndex,
          children: _views,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.dashboard_rounded, label: 'Control Tower', index: 0, selectedIndex: _selectedModuleIndex, onTap: (i) => setState(() => _selectedModuleIndex = i)),
              _NavItem(icon: Icons.local_shipping_rounded, label: 'Visibility', index: 1, selectedIndex: _selectedModuleIndex, onTap: (i) => setState(() => _selectedModuleIndex = i)),
              _NavItem(icon: Icons.alt_route_rounded, label: 'AI Routes', index: 2, selectedIndex: _selectedModuleIndex, onTap: (i) => setState(() => _selectedModuleIndex = i)),
              _NavItem(icon: Icons.psychology_rounded, label: 'AI Assistant', index: 3, selectedIndex: _selectedModuleIndex, onTap: (i) => setState(() => _selectedModuleIndex = i)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF3B82F6) : Colors.blueGrey,
              size: 22,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label.split(' ').first, // just first word to keep it compact
                style: const TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AIAssistantView extends StatelessWidget {
  const AIAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.psychology_rounded, size: 64, color: Color(0xFF10B981)),
          SizedBox(height: 16),
          Text('AI Assistant Interface', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('How can I help you optimize your logistics today?'),
        ],
      ),
    );
  }
}

class ControlTowerDashboardView extends StatelessWidget {
  const ControlTowerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LogiSphere AI',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                    ),
                    const Text(
                      'Control Tower',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF3B82F6)),
                    ),
                    const SizedBox(height: 2),
                    Text('Real-time global logistics overview', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                onPressed: () {},
                icon: const Icon(Icons.bolt, color: Colors.white, size: 16),
                label: const Text('AI Optimize', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: const [
                KpiCard(title: 'Active Shipments', value: '1,248', icon: Icons.local_shipping, color: Colors.blue),
                KpiCard(title: 'At-Risk Delays', value: '14', icon: Icons.warning_amber_rounded, color: Colors.amber),
                KpiCard(title: 'Customs Exceptions', value: '3', icon: Icons.gavel_rounded, color: Colors.red),
                KpiCard(title: 'AI Cost Savings', value: '\$42,150', icon: Icons.auto_graph_rounded, color: Color(0xFF10B981)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const KpiCard({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 11)),
                ),
                Icon(icon, color: color, size: 18),
              ],
            ),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}