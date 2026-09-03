import 'package:flutter/material.dart';
import 'package:water_sos/core/design_system/app_color/app_gradients.dart';
import 'package:water_sos/core/design_system/theme_data/theme_extension.dart';
import 'package:water_sos/core/extension/text_style_extension.dart';
import 'package:water_sos/features/location_flow/data/dummy_data.dart';

class StepProgressBar extends StatelessWidget {
  final List<StepDef> steps;
  final int currentIndex;

  const StepProgressBar({
    super.key,
    required this.steps,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final safeIndex = currentIndex.clamp(0, steps.length - 1);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              steps.length * 2 - 1,
                  (index) {
                if (index.isOdd) {
                  final connectorIndex = index ~/ 2;

                  return Expanded(
                    child: _StepConnector(
                      completed: connectorIndex < safeIndex,
                    ),
                  );
                }

                final stepIndex = index ~/ 2;

                return _StepNode(
                  index: stepIndex,
                  step: steps[stepIndex],
                  isCurrent: stepIndex == safeIndex,
                  isDone: stepIndex < safeIndex,
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: Text(
              steps[safeIndex].label,
              key: ValueKey(steps[safeIndex].key),
              style: context.font14Bold?.copyWith(
                color: context.colors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _StepNode extends StatelessWidget {
  final int index;
  final StepDef step;
  final bool isCurrent;
  final bool isDone;

  const _StepNode({
    required this.index,
    required this.step,
    required this.isCurrent,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primaryColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: isCurrent ? 34 : 28,
      height: isCurrent ? 34 : 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone || isCurrent
            ? primary
            : Colors.white,
        border: Border.all(
          color: isDone || isCurrent
              ? primary
              : const Color(0xFFD3DCEC),
          width: isCurrent ? 2.5 : 1.5,
        ),
        boxShadow: isCurrent
            ? [
          BoxShadow(
            color: primary.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ]
            : null,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: isDone
            ? const Icon(
          Icons.check_rounded,
          key: ValueKey('done'),
          size: 17,
          color: Colors.white,
        )
            : isCurrent
            ? const Icon(
          Icons.circle,
          key: ValueKey('current'),
          size: 9,
          color: Colors.white,
        )
            : Text(
          '${index + 1}',
          key: const ValueKey('pending'),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }
}
class _StepConnector extends StatelessWidget {
  final bool completed;

  const _StepConnector({
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: completed
            ? AppGradients.primary
            : AppGradients.background,
      ),
    );
  }
}