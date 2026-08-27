import 'package:flutter/material.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/presentation/screens/location_selection.dart';
import 'package:water_sos/presentation/screens/map_illustration.dart';
import 'package:water_sos/presentation/screens/selectable_tile.dart';
import 'package:water_sos/presentation/screens/shared_widgets.dart';

class SelectRegionScreen extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectRegionScreen({super.key, required this.selection, required this.onNext});

  @override
  State<SelectRegionScreen> createState() => _SelectRegionScreenState();
}

class _SelectRegionScreenState extends State<SelectRegionScreen> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selection.region;
  }

  @override
  Widget build(BuildContext context) {
    final gov = widget.selection.governorate ?? DummyData.governorates.first;
    final regions = DummyData.regionsByGovernorate[gov] ?? const [];

    return StepScaffold(
      title: 'اختر منطقتك',
      subtitle: 'اختر المنطقة التابعة لمحافظة $gov',
      illustration: const MapIllustration(),
      body: Column(
        children: [
          SelectedValueBar(label: 'المحافظة المحددة', value: gov),
          const SizedBox(height: 12),
          ...regions.map((r) {
            return SelectableTile(
              label: r,
              selected: selected == r,
              leadingIcon: Icons.map,
              onTap: () => setState(() => selected = r),
            );
          }),
        ],
      ),
      footer: NextButton(
        enabled: selected != null,
        onPressed: () => widget.onNext(selected!),
      ),
    );
  }
}
