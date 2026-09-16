import 'package:flutter/material.dart';
import '../card/custom_card.dart';
import '../color/custom_color.dart';


/// Occupancy progress bar with label + percentage.
class OccupancyBar extends StatelessWidget {
  final int current;
  final int max;
  final double percent;
  final int percentInt;

  const OccupancyBar({
    super.key,
    required this.current,
    required this.max,
    required this.percent,
    required this.percentInt,
  });

  Color _fillColor() {
    if (percent >= 0.85) return CustomColor.occupancyHigh;
    if (percent >= 0.6) return CustomColor.occupancyMedium;
    return CustomColor.occupancyLow;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard1(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_outlined,
                  size: 18, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Occupancy Real-Time',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Text(
                '$current / $max  ($percentInt%)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent.clamp(0, 1),
              minHeight: 8,
              backgroundColor: CustomColor.occupancyTrack(context),
              valueColor: AlwaysStoppedAnimation<Color>(_fillColor()),
            ),
          ),
        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------
// Top bar (dark navy header, matches the rest of the FleetTrack app)
// ---------------------------------------------------------------------
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.headerBg(context),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: CustomColor.onDark),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: CustomColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_bus_filled_outlined,
                color: CustomColor.onDark, size: 20),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Trip Manifest Detail',
              style: TextStyle(
                color: CustomColor.onDark,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: CustomColor.onDarkFaint,
            child: Icon(Icons.person, color: CustomColor.onDark),
          ),
        ],
      ),
    );
  }
}
// Search bar with a leading search icon and trailing filter button.
class SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: CustomColor.searchBarBg(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CustomColor.searchBarBorder(context)),
            ),
            child: Row(
              children: [
                Icon(Icons.search,
                    size: 18, color: CustomColor.searchIconColor(context)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    style: TextStyle(
                      fontSize: 13,
                      color: CustomColor.textPrimary(context),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: CustomColor.inputHintDefault(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onFilterTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: CustomColor.searchBarBg(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CustomColor.searchBarBorder(context)),
            ),
            child: Icon(Icons.tune_outlined,
                size: 18, color: CustomColor.textSecondary(context)),
          ),
        ),
      ],
    );
  }
}



/// Rounded search bar with a leading search icon and trailing mic button.
class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMicTap;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: CustomColor.textSecondary(context)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14,
                color: CustomColor.textPrimary(context),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: CustomColor.inputHintDefault(context),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onMicTap,
            child: Icon(Icons.mic_none_outlined,
                size: 20, color: CustomColor.primary),
          ),
        ],
      ),
    );
  }
}



/// Thin seat-capacity progress bar. Color reflects how full the bus is.
class CapacityBar extends StatelessWidget {
  final double percent; // 0.0 - 1.0

  const CapacityBar({super.key, required this.percent});

  Color _fillColor() {
    if (percent >= 0.85) return CustomColor.capacityFull;
    if (percent >= 0.6) return CustomColor.capacityFewSeats;
    return CustomColor.capacitySpacious;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        value: percent.clamp(0, 1),
        minHeight: 6,
        backgroundColor: CustomColor.capacityTrack(context),
        valueColor: AlwaysStoppedAnimation<Color>(_fillColor()),
      ),
    );
  }
}

