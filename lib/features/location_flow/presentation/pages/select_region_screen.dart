import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selectable_tile.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selected_value_bar.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_scaffold.dart';
import 'package:water_sos/shared/widgets/custom_elevated_button.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/map_illustration.dart';

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
      illustration:  MapIllustration(   image: AppImages.imageRegion,),
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
      footer: CustomElevatedButton(
        text: "التالي",
        onPressed: () => widget.onNext(selected!),
      ),

    );
  }
}
