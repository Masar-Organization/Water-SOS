import 'package:flutter/material.dart';

class InfoBanner extends StatelessWidget {
  final String title;
  final String text;
  const InfoBanner({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF1657D6), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1657D6))),
                const SizedBox(height: 4),
                Text(text, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TipsBox extends StatelessWidget {
  final String title;
  final List<(IconData, String)> tips;

  const TipsBox({super.key, required this.title, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF1657D6)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1657D6))),
            ],
          ),
          const Divider(height: 20),
          for (final tip in tips)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(tip.$1, size: 18, color: const Color(0xFF1657D6)),
                  Expanded(
                    child: Text(tip.$2, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SelectedValueBar extends StatelessWidget {
  final String label;
  final String value;
  const SelectedValueBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E8F2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.location_on, color: Color(0xFF1657D6), size: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(label, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                if (value.isNotEmpty)
                  Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onEdit;

  const ReviewTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E8F2)),
      ),
      child: Row(
        children: [
          if (onEdit != null)
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.chevron_left, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFEFF3FC),
            child: Icon(icon, size: 16, color: const Color(0xFF1657D6)),
          ),
        ],
      ),
    );
  }
}
