import 'package:flutter/cupertino.dart';
import '../models/distance_unit.dart';
import '../data/units_data.dart';

class UnitPickerScreen extends StatelessWidget {
  final DistanceUnit currentUnit;
  const UnitPickerScreen({super.key, required this.currentUnit});

  static const Map<UnitSystem, String> _sectionTitles = {
    UnitSystem.metric: 'Metric',
    UnitSystem.imperial: 'Imperial / US',
    UnitSystem.nautical: 'Nautical',
    UnitSystem.astronomical: 'Astronomical',
  };

  @override
  Widget build(BuildContext context) {
    final grouped = <UnitSystem, List<DistanceUnit>>{};
    for (final unit in UnitsData.all) {
      grouped.putIfAbsent(unit.system, () => []).add(unit);
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Choose a unit'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            for (final system in UnitSystem.values)
              if (grouped[system] != null)
                CupertinoListSection.insetGrouped(
                  header: Text(_sectionTitles[system]!),
                  children: [
                    for (final unit in grouped[system]!)
                      CupertinoListTile(
                        title: Text(unit.name),
                        subtitle: Text(unit.symbol),
                        trailing: unit.symbol == currentUnit.symbol
                            ? const Icon(CupertinoIcons.check_mark)
                            : null,
                        onTap: () => Navigator.pop(context, unit),
                      ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
