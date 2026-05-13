import 'package:flutter/material.dart';

import '../../domain/entities/accessory_slot.dart';

class AccessoryCategoryTabs extends StatelessWidget {
  final AccessorySlot selectedSlot;
  final ValueChanged<AccessorySlot> onChanged;

  const AccessoryCategoryTabs({
    super.key,
    required this.selectedSlot,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: AccessorySlot.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final slot = AccessorySlot.values[index];
          final selected = slot == selectedSlot;

          return ChoiceChip(
            label: Text(slot.label),
            selected: selected,
            onSelected: (_) => onChanged(slot),
            selectedColor: const Color(0xFF8B5CF6),
            backgroundColor: Colors.white.withValues(alpha: 0.06),
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          );
        },
      ),
    );
  }
}
