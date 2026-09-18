import 'package:flutter/material.dart';

void main() {
  runApp(const CrossPlatformFrameworksApp());
}

class CrossPlatformFrameworksApp extends StatelessWidget {
  const CrossPlatformFrameworksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Кроссплатформенные фреймворки',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0553B1)),
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
        useMaterial3: true,
      ),
      home: const FrameworkPage(),
    );
  }
}

class FrameworkPage extends StatelessWidget {
  const FrameworkPage({super.key});

  static const String studentName = 'ФИО СТУДЕНТА';
  static const String studentGroup = 'НОМЕР ГРУППЫ';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        centerTitle: true,
        title: const Text(
          'Кроссплатформенные фреймворки',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 680),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x18001A3A),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Flutter',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Flutter — кроссплатформенный фреймворк для создания '
                    'мобильных, веб- и настольных приложений из единой кодовой '
                    'базы. Интерфейс строится из виджетов, а код пишется на Dart.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, height: 1.45),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool isCompact = constraints.maxWidth < 520;
                    const Widget logo = _FrameworkLogo();
                    const Widget features = _FeatureList();

                    if (isCompact) {
                      return const Column(
                        children: [
                          _FrameworkLogo(),
                          SizedBox(height: 20),
                          _FeatureList(),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: logo),
                        const SizedBox(width: 24),
                        const Expanded(child: features),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 44,
                        color: Color(0xFF0553B1),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentName,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Группа: $studentGroup',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FrameworkLogo extends StatelessWidget {
  const _FrameworkLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4E5F8)),
      ),
      child: Image.asset(
        'assets/flutter-mark-square-64.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        semanticLabel: 'Логотип Flutter',
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  const _FeatureList();

  static const List<(IconData, String)> features = [
    (Icons.code, 'Язык программирования Dart'),
    (Icons.layers_outlined, 'Единая кодовая база'),
    (Icons.bolt, 'Быстрая разработка с Hot Reload'),
    (Icons.devices, 'Android, iOS, Web и Desktop'),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Основные особенности',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final (IconData icon, String label) in features) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 22, color: primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16, height: 1.35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
        ],
      ],
    );
  }
}
