import "package:flutter/material.dart" show Widget;

/// Individual data of a RadioListTile custom, used on 
/// [RadioListSelector]
class RadioSelectOptionEntity<J> {

  /// Construct of the data element
  RadioSelectOptionEntity({

    required this.title,
    required this.leading,
    required this.value,

  });

  /// String label that will show in the RadioListTile
  final String title;

  /// Leading widget to the radio option, Typically a icon that will show in the RadioListTile
  final Widget? leading;

  /// Value that will represets the own RadioListTile, individually
  final J value;

}
