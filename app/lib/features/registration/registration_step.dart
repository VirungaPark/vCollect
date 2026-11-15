import 'package:flutter/material.dart';

import '../../strings.dart';

/// The steps of the farmer registration flow, in order.
///
/// The step indicator is built from this list, so a new step only needs an
/// entry here and a screen that links to it.
enum RegistrationStep {
  findFarmer(
    AppStrings.findFarmerTitle,
    AppStrings.findFarmerDescription,
    Icons.person_search,
  ),
  idCard(AppStrings.idCardTitle, AppStrings.idCardDescription, Icons.badge),
  fieldWalk(
    AppStrings.fieldWalkTitle,
    AppStrings.fieldWalkDescription,
    Icons.directions_walk,
  ),
  summarySignature(
    AppStrings.summarySignatureTitle,
    AppStrings.summarySignatureDescription,
    Icons.draw,
  );

  const RegistrationStep(this.title, this.description, this.icon);

  final String title;
  final String description;
  final IconData icon;

  /// 1-based position, as shown to the agent.
  int get number => index + 1;
}

/// Shared frame for every registration step: "Step n of N" in the app bar,
/// the step indicator, the step's content and a large Next button.
///
/// Opened over the whole app, so the bottom navigation bar is hidden during
/// the flow. On the last step the button reads Done and returns to Home.
class RegistrationStepScaffold extends StatelessWidget {
  const RegistrationStepScaffold({
    super.key,
    required this.step,
    required this.body,
    this.nextScreen,
  }) : assert(
         (nextScreen == null) == (step == RegistrationStep.summarySignature),
         'Only the last step has no next screen',
       );

  final RegistrationStep step;
  final Widget body;

  /// Builds the following step's screen. Null on the last step.
  final WidgetBuilder? nextScreen;

  @override
  Widget build(BuildContext context) {
    final nextScreen = this.nextScreen;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.stepOf(step.number, RegistrationStep.values.length),
        ),
      ),
      body: Column(
        children: [
          _StepIndicator(current: step),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            onPressed: () {
              final navigator = Navigator.of(context);
              if (nextScreen == null) {
                navigator.popUntil((route) => route.isFirst);
              } else {
                navigator.push(MaterialPageRoute<void>(builder: nextScreen));
              }
            },
            child: Text(nextScreen == null ? AppStrings.done : AppStrings.next),
          ),
        ),
      ),
    );
  }
}

/// One icon per step. The step's name appears in a tooltip only when the
/// agent taps the icon, so the indicator stays uncluttered but the name is
/// there when they need to check or remember it.
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current});

  final RegistrationStep current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final step in RegistrationStep.values)
            Tooltip(
              message: step.title,
              triggerMode: TooltipTriggerMode.tap,
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step == current ? colors.primaryContainer : null,
                  border: Border.all(color: colors.outline),
                ),
                child: Icon(
                  step.index < current.index ? Icons.check : step.icon,
                  color: step == current
                      ? colors.onPrimaryContainer
                      : colors.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
