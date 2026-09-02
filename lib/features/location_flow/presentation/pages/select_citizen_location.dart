import 'package:flutter/material.dart';
import 'package:water_sos/core/constants/app_images.dart';
import 'package:water_sos/core/constants/location_selection.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/selectable_tile.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/step_scaffold.dart';
import 'package:water_sos/shared/widgets/custom_elevated_button.dart';
import 'package:water_sos/features/location_flow/presentation/widgets/map_illustration.dart';

class SelectCitizenLocation extends StatefulWidget {
  final LocationSelection selection;
  final ValueChanged<String> onNext;
  const SelectCitizenLocation({
    super.key,
    required this.selection,
    required this.onNext,
  });

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
      illustration: MapIllustration(
        image: AppImages.imageIllustration,
        //  image: selected == 'GPS' ? AppImages.imageGpsIllustration : AppImages.imageManualIllustration,
      ),
      body: Column(
        children: DummyData.methods.map((m) {
          final isSelected = selected == m;
          return SelectableTile(
            label: m,
            selected: isSelected,
            leadingIcon: m.contains('GPS')
                ? Icons.gps_fixed
                : Icons.edit_location_alt,
            onTap: () => setState(() => selected = m),
          );
        }).toList(),
      ),
      footer: CustomElevatedButton(
        text: "التالي",
        onPressed: () => widget.onNext(selected!),
      ),
    );
  }
}
