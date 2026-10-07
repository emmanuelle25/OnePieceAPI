import 'package:flutter/material.dart';
import '../services/onepiece_service.dart';
import '../theme/app_theme.dart';
import 'offline_art.dart';

class ResourceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Map<String, dynamic>? data;

  const ResourceCard({super.key, required this.title, required this.subtitle, required this.icon, this.onTap, this.data});

  String _secondary() {
    if (data == null) return subtitle;
    final preferred = ['role', 'type', 'bounty', 'year', 'number', 'effect', 'description'];
    for (final key in preferred) {
      final value = data![key];
      if (value != null && value.toString().trim().isNotEmpty) return value.toString();
    }
    return subtitle;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final image = data == null ? null : OnePieceService.imageUrl(data!);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 11),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 92,
                width: double.infinity,
                child: image == null
                    ? OfflineArt(icon: icon, height: 92)
                    : Image.network(image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => OfflineArt(icon: icon, height: 92)),
              ),
            ),
            const SizedBox(height: 10),
            Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14.5)),
            const SizedBox(height: 4),
            Text(_secondary(), maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11.5)),
            const SizedBox(height: 9),
            Row(children: [Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppTheme.vermelho.withValues(alpha: .12), borderRadius: BorderRadius.circular(20)))), const SizedBox(width: 8), const Icon(Icons.chevron_right_rounded, size: 18, color: AppTheme.vermelho)]),
          ]),
        ),
      ),
    );
  }
}
