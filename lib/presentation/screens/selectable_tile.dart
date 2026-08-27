import 'package:flutter/material.dart';

class SelectableTile extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const SelectableTile({
    super.key,
    required this.label,
    required this.selected,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? const Color(0xFF1657D6) : const Color(0xFFE3E8F2),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: selected ? const Color(0xFF1657D6) : Colors.grey),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? const Color(0xFF1657D6) : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                backgroundColor: const Color(0xFFEFF3FC),
                child: Icon(leadingIcon, size: 16, color: const Color(0xFF1657D6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
