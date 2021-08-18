import 'package:flutter/material.dart';

import '../../../../../../core/resources/constants/constants.dart';

class CharacterInformationPill extends StatelessWidget {
  const CharacterInformationPill({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    const _labelBackgroundColor = AppColors.green;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: _Label(labelBackgroundColor: _labelBackgroundColor, labelText: label)),
          Expanded(flex: 6, child: _Content(labelBackgroundColor: _labelBackgroundColor, value: value)),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required Color? labelBackgroundColor,
    required this.value,
  })  : _labelBackgroundColor = labelBackgroundColor,
        super(key: key);

  final Color? _labelBackgroundColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: _labelBackgroundColor!),
        color: _labelBackgroundColor?.withOpacity(.2),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Text(
        value,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required Color? labelBackgroundColor,
    required this.labelText,
  })  : _labelBackgroundColor = labelBackgroundColor,
        super(key: key);

  final Color? _labelBackgroundColor;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _labelBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
