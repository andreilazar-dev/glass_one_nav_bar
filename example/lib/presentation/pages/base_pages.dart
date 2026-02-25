import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      title: 'Home',
      items: List.generate(10, (index) => 'Latest Update ${index + 1}'),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      title: 'Explore',
      items: List.generate(10, (index) => 'New Discovery ${index + 1}'),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      title: 'Analytics',
      items: List.generate(10, (index) => 'Data Report ${index + 1}'),
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BasePage(
      title: 'Community',
      items: List.generate(10, (index) => 'Member Post ${index + 1}'),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  const DetailPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details for $title', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BasePage extends StatelessWidget {
  final String title;
  final List<String> items;

  const _BasePage({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(items[index]),
              subtitle: Text('Trial description for $title #$index'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                if (title == 'Explore') {
                  context.go('/explore/item/${index + 1}');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
