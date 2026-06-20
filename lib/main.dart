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
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
        cardColor: const Color(0xFF1E293B), // Slate 800
        primaryColor: const Color(0xFF3B82F6), // Blue 500
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF10B981), // Emerald 500
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: const Color(0xFF020617), // Slate 955
            selectedIndex: _selectedModuleIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedModuleIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: const IconThemeData(color: Color(0xFF3B82F6)),
            // FIX: Changed Colors.slate to Colors.blueGrey
            unselectedIconTheme: const IconThemeData(color: Colors.blueGrey),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard_rounded), label: Text('Control Tower')),
              NavigationRailDestination(icon: Icon(Icons.local_shipping_rounded), label: Text('Visibility')),
              NavigationRailDestination(icon: Icon(Icons.alt_route_rounded), label: Text('AI Routes')),
              NavigationRailDestination(icon: Icon(Icons.psychology_rounded), label: Text('AI Assistant')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.white10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: IndexedStack(
                index: _selectedModuleIndex,
                children: [
                  const ControlTowerDashboardView(),
                  const Center(child: Text('Module 1: Real-time Shipment Tracking View')),
                  const Center(child: Text('Module 2: AI Dynamic Route Optimizer')),
                  const AIAssistantView(), // This now has a definition below
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FIX: Added missing AIAssistantView class
class AIAssistantView extends StatelessWidget {
  const AIAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LogiSphere AI // Control Tower',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                ),
                const SizedBox(height: 4),
                Text('Real-time global logistics overview', style: TextStyle(color: Colors.grey[400])),
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
              onPressed: () {},
              icon: const Icon(Icons.bolt, color: Colors.white),
              label: const Text('AI Optimization Run', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        const SizedBox(height: 32),
        Expanded(
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: const [
              KpiCard(title: 'Active Shipments', value: '1,248', icon: Icons.local_shipping, color: Colors.blue),
              KpiCard(title: 'At-Risk Delays', value: '14', icon: Icons.warning_amber_rounded, color: Colors.amber),
              KpiCard(title: 'Customs Exceptions', value: '3', icon: Icons.gavel_rounded, color: Colors.red),
              KpiCard(title: 'AI Predicted Cost Savings', value: '\$42,150', icon: Icons.auto_graph_rounded, color: Color(0xFF10B981)),
            ],
          ),
        ),
      ],
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.white10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
                Icon(icon, color: color),
              ],
            ),
            Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}