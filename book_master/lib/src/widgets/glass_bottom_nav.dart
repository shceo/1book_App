import 'package:flutter/material.dart';

class GlassNavItem {
  final IconData icon;
  final String label;
  const GlassNavItem({required this.icon, required this.label});
}

class GlassBottomNav extends StatelessWidget {
  final int index;
  final List<GlassNavItem> items;
  final ValueChanged<int> onChanged;

  const GlassBottomNav({
    super.key,
    required this.index,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = i == index;
          final item = items[i];

          return Expanded(
            child: SizedBox.expand(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selected ? Colors.white.withValues(alpha: 0.14) : Colors.transparent,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () => onChanged(i),
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.white.withValues(alpha: 0.20),
                    highlightColor: Colors.white.withValues(alpha: 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 22,
                          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.72),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: selected ? Colors.white : Colors.white.withValues(alpha: 0.70),
                            ),
                            child: Text(
                              item.label,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
