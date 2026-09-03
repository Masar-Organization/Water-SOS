import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/core/extension/app_sizes.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selectable_tile.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selected_value_bar.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_scaffold.dart';
import 'package:water_sos/shared/widgets/custom_elevated_button.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/map_illustration.dart';

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
        spacing: context.height(12),
        children: [
          SelectedValueBar(
            label: 'المحافظة: $gov  |  المنطقة: $region',
            value: '',
          ),

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
