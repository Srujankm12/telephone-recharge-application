import 'package:flutter/material.dart';

class RadioButtons extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const RadioButtons({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(value: "2", label: Text("Restricted")),
        ButtonSegment<String>(value: "1", label: Text("Free to dial")),
      ],
      selected: <String>{selectedValue},
      onSelectionChanged: (Set<String> newSelection) {
        onChanged(newSelection.first);
      },
    );
  }
}
