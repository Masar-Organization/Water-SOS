import 'package:flutter/material.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/presentation/screens/location_selection.dart';
import 'package:water_sos/presentation/screens/map_illustration.dart';
import 'package:water_sos/presentation/screens/selectable_tile.dart';

/// Just collects which method the citizen wants to use. It does **not**
/// decide what happens next — that branching (GPS capture vs. manual
/// address entry) lives in `LocationFlowScreen._onMethodChosen`, since this
/// widget only knows about itself, not about the rest of the flow.
class SelectCitizenLocation extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectCitizenLocation({super.key, required this.selection, required this.onNext});

  @override
  State<SelectCitizenLocation> createState() => _SelectCitizenLocationState();
}

class _SelectCitizenLocationState extends State<SelectCitizenLocation> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selection.method;
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'اختر طريقة تحديد موقعك',
      subtitle: 'يمكنك استخدام GPS أو إدخال العنوان يدوياً',
      illustration: const MapIllustration(),
      body: Column(
        children: DummyData.methods.map((m) {
          final isSelected = selected == m;
          return SelectableTile(
            label: m,
            selected: isSelected,
            leadingIcon: m.contains('GPS') ? Icons.gps_fixed : Icons.edit_location_alt,
            onTap: () => setState(() => selected = m),
          );
        }).toList(),
      ),
      footer: NextButton(
        enabled: selected != null,
        onPressed: () => widget.onNext(selected!),
      ),
    );
  }
}
