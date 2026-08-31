import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/data/dummy_data.dart';
import 'package:water_sos/presentation/screens/location_flow_screen.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/presentation/widgets/custom_elevated_button.dart';
import 'package:water_sos/presentation/widgets/location_flow/selected_value_bar.dart';
import 'package:water_sos/presentation/widgets/location_flow/step_scaffold.dart';
import 'package:water_sos/presentation/widgets/map_illustration.dart';
import 'package:water_sos/presentation/widgets/location_flow/selectable_tile.dart';
import 'package:water_sos/presentation/widgets/location_flow/review_tile.dart';

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
