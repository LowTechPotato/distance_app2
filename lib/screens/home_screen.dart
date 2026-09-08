import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import '../models/place.dart';
import '../models/distance_unit.dart';
import '../data/cities_data.dart';
import '../data/units_data.dart';
import '../services/location_service.dart';
import '../services/distance_service.dart';
import '../utils/number_formatter.dart';
import '../utils/coordinate_formatter.dart';
import 'city_picker_screen.dart';
import 'unit_picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Place _selectedPlace = CitiesData.all.firstWhere((c) => c.name == 'Tokyo');
  DistanceUnit _selectedUnit = UnitsData.defaultUnit;

  Position? _userPosition;
  bool _loadingLocation = true;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    setState(() {
      _loadingLocation = true;
      _locationError = null;
    });

    final position = await LocationService.getCurrentPosition();

    if (!mounted) return;
    setState(() {
      _userPosition = position;
      _loadingLocation = false;
      if (position == null) {
        _locationError = "Can't get your location — tap to retry";
      }
    });
  }

  Future<void> _pickPlace() async {
    final result = await Navigator.push<Place>(
      context,
      CupertinoPageRoute(
        builder: (_) => CityPickerScreen(currentPlace: _selectedPlace),
      ),
    );
    if (result != null) {
      setState(() => _selectedPlace = result);
    }
  }

  Future<void> _pickUnit() async {
    final result = await Navigator.push<DistanceUnit>(
      context,
      CupertinoPageRoute(
        builder: (_) => UnitPickerScreen(currentUnit: _selectedUnit),
      ),
    );
    if (result != null) {
      setState(() => _selectedUnit = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final needsLocation = _selectedPlace.type == PlaceType.city;
    final canCompute = !needsLocation || _userPosition != null;

    String distanceText = '—';
    if (canCompute) {
      final meters = DistanceService.distanceInMeters(
        place: _selectedPlace,
        userLat: _userPosition?.latitude,
        userLon: _userPosition?.longitude,
      );
      final valueInUnit = meters / _selectedUnit.metersPerUnit;
      distanceText = NumberFormatter.format(valueInUnit);
    }

    final coordinatesText = _userPosition != null
        ? CoordinateFormatter.format(
            _userPosition!.latitude, _userPosition!.longitude)
        : (_loadingLocation ? 'Locating…' : 'Location unavailable');

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // Heading
              const Text(
                'How far am I from...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),

              const SizedBox(height: 14),

              // Selected place
              GestureDetector(
                onTap: _pickPlace,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedPlace.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(CupertinoIcons.chevron_down, size: 22),
                  ],
                ),
              ),

              const Spacer(),

              // Distance
              if (_loadingLocation && needsLocation)
                const CupertinoActivityIndicator(radius: 16)
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: Text(
                        distanceText,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _pickUnit,
                      child: Row(
                        children: [
                          Text(
                            _selectedUnit.symbol,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(CupertinoIcons.chevron_down, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),

              if (_locationError != null && needsLocation) ...[
                const SizedBox(height: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _loadLocation,
                  child: Text(
                    _locationError!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],

              const Spacer(),
              const Spacer(),

              // Current coordinates
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  coordinatesText,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
