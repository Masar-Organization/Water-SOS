import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selectable_tile.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selected_value_bar.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_scaffold.dart';
import 'package:water_sos/shared/widgets/custom_elevated_button.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/map_illustration.dart';

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
      illustration:  MapIllustration(
        image: AppImages.imageGovernorate,
      ),
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
      footer: CustomElevatedButton(
        text: "التالي",
        onPressed: () => widget.onNext(selected!),
      ),

    );
  }
}
