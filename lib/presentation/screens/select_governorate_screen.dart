import 'package:flutter/material.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/presentation/screens/location_selection.dart';
import 'package:water_sos/presentation/screens/map_illustration.dart';
import 'package:water_sos/presentation/screens/selectable_tile.dart';
import 'package:water_sos/presentation/screens/shared_widgets.dart';

class SelectGovernorateScreen extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectGovernorateScreen({super.key, required this.selection, required this.onNext});

  @override
  State<SelectGovernorateScreen> createState() => _SelectGovernorateScreenState();
}

class _SelectGovernorateScreenState extends State<SelectGovernorateScreen> {
  String? selected;

  @override
  void initState() {
    super.initState();
    // Pre-filled automatically when the governorate came from a GPS fix,
    // but the citizen can still tap another one below.
    selected = widget.selection.governorate;
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'اختر محافظتك',
      subtitle: widget.selection.wasCapturedByGps
          ? 'تم اقتراح المحافظة تلقائياً بناءً على موقعك، ويمكنك تغييرها'
          : 'اختر المحافظة التي تقع بها',
      illustration: const MapIllustration(),
      body: Column(
        children: [
          if (widget.selection.wasCapturedByGps)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SelectedValueBar(label: 'تم التحديد عبر GPS', value: selected ?? ''),
            ),
          ...DummyData.governorates.map((g) {
            return SelectableTile(
              label: g,
              selected: selected == g,
              leadingIcon: Icons.account_balance,
              onTap: () => setState(() => selected = g),
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
