import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import '../data/cities_data.dart';
import '../data/celestial_data.dart';

class CityPickerScreen extends StatefulWidget {
  final Place currentPlace;
  const CityPickerScreen({super.key, required this.currentPlace});

  @override
  State<CityPickerScreen> createState() => _CityPickerScreenState();
}

class _CityPickerScreenState extends State<CityPickerScreen> {
  String _query = '';

  static final List<Place> _allPlaces = [
    ...CitiesData.all,
    ...CelestialData.all,
  ];

  List<Place> get _filtered {
    if (_query.isEmpty) return _allPlaces;
    final q = _query.toLowerCase();
    return _allPlaces.where((p) {
      final nameMatch = p.name.toLowerCase().contains(q);
      final countryMatch = (p.country ?? '').toLowerCase().contains(q);
      return nameMatch || countryMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Choose a place'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CupertinoSearchTextField(
                autofocus: true,
                placeholder: 'Search city or planet',
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('Nothing found'))
                  : ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) => Container(
                        height: 0.5,
                        margin: const EdgeInsets.only(left: 16),
                        color: CupertinoColors.separator.resolveFrom(context),
                      ),
                      itemBuilder: (context, index) {
                        final place = results[index];
                        final isSelected =
                            place.name == widget.currentPlace.name;
                        return CupertinoListTile(
                          leading: Icon(
                            place.type == PlaceType.celestial
                                ? CupertinoIcons.globe
                                : CupertinoIcons.location_solid,
                          ),
                          title: Text(place.name),
                          subtitle: place.country != null
                              ? Text(place.country!)
                              : null,
                          trailing: isSelected
                              ? const Icon(CupertinoIcons.check_mark)
                              : null,
                          onTap: () => Navigator.pop(context, place),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
