import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/data/dummy_data.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/presentation/widgets/custom_elevated_button.dart';
import 'package:water_sos/presentation/widgets/location_flow/selected_value_bar.dart';
import 'package:water_sos/presentation/widgets/location_flow/step_scaffold.dart';
import 'package:water_sos/presentation/widgets/map_illustration.dart';
import 'package:water_sos/presentation/widgets/location_flow/selectable_tile.dart';

class SelectStreetScreen extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectStreetScreen({
    super.key,
    required this.selection,
    required this.onNext,
  });

  @override
  State<SelectStreetScreen> createState() => _SelectStreetScreenState();
}

class _SelectStreetScreenState extends State<SelectStreetScreen> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selection.streetNeighborhood;
  }

  @override
  Widget build(BuildContext context) {
    final gov = widget.selection.governorate ?? '';
    final region = widget.selection.region ?? '';
    final streets =
        DummyData.streetsByRegion[region] ?? DummyData.defaultStreets;

    return StepScaffold(
      title: 'اختر الحي/الشارع',
      subtitle: 'اختر الحي أو الشارع التابع للمنطقة المحددة',
      illustration: MapIllustration(image: AppImages.imageStreet),
      body: Column(
        children: [
          SelectedValueBar(
            label: 'المحافظة: $gov  |  المنطقة: $region',
            value: '',
          ),
          const SizedBox(height: 12),
          ...streets.map((s) {
            return SelectableTile(
              label: s,
              selected: selected == s,
              leadingIcon: Icons.location_on_outlined,
              onTap: () => setState(() => selected = s),
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
