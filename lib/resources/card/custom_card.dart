import 'package:flutter/material.dart';
import '../../providers/driver_provider/history_provider.dart';
import '../../providers/driver_provider/notifications_provider.dart';
import '../../providers/driver_provider/sos_provider.dart';
import '../../providers/passenger_provider/dashboard_provider.dart';
import '../../providers/passenger_provider/sos_provider.dart';
import '../badge/badge.dart';
import 'dart:io';
import '../banner/custom_banner.dart';
import '../bar/custom_bar.dart';
import '../bottom/driver_button.dart';
import '../chip/custom_chip.dart';
import '../color/custom_color.dart';
import '../tile/custom_tile.dart';
import '../widgets/custom_widgets.dart';

/// =========================================================
/// NOTICE BANNER (Koshi Highway road expansion alert)
/// =========================================================
class NoticeBanner extends StatelessWidget {
  final String title;
  final String message;

  const NoticeBanner({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.withOpacity(.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 13),
                children: [
                  TextSpan(
                    text: "$title  ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  TextSpan(text: message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// DRIVER PROFILE CARD
/// (photo, name, rating, trips, license, bus info, corridor, shift)
/// =========================================================


class DriverProfileCard extends StatelessWidget {
  final String driverName;
  final String driverCode;
  final String photoUrl;
  final File? localPhotoFile;
  final double rating;
  final int totalTrips;
  final String licenseNo;

  final String busName;
  final String plateNumber;
  final String seatInfo;
  final bool inService;

  final String corridorLabel;
  final String corridorRoute;

  final String shiftTime;
  final String shiftLabel;
  final String remainingTime;

  const DriverProfileCard({
    super.key,
    required this.driverName,
    required this.driverCode,
    required this.photoUrl,
    this.localPhotoFile,
    required this.rating,
    required this.totalTrips,
    required this.licenseNo,
    required this.busName,
    required this.plateNumber,
    required this.seatInfo,
    required this.inService,
    required this.corridorLabel,
    required this.corridorRoute,
    required this.shiftTime,
    required this.shiftLabel,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Driver row ---
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: localPhotoFile != null
                        ? FileImage(localPhotoFile!) as ImageProvider
                        : NetworkImage(photoUrl),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: CustomColor.card_bg(context),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            driverName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.textPrimary(context),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            driverCode,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),

                        Text(
                          "$rating",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            "${totalTrips} trips • Lic: $licenseNo",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.textSecondary(context),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.qr_code_2, size: 22),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- Bus info row ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "बा २",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        plateNumber.split(" ").last,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        busName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        seatInfo,
                        style: TextStyle(
                          fontSize: 12,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    inService ? "IN\nSERVICE" : "OFFLINE",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // --- Corridor row ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.near_me, size: 16, color: Colors.indigo),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      corridorLabel.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: .5,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      corridorRoute,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 10),

          // --- Shift row ---
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "$shiftTime ($shiftLabel)",
                  style: TextStyle(
                    fontSize: 13,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Text(
                "$remainingTime Remaining",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/// =========================================================
/// OCCUPANCY CARD
/// =========================================================
class OccupancyCard extends StatelessWidget {
  final int occupied;
  final int capacity;
  final String note;

  const OccupancyCard({
    super.key,
    required this.occupied,
    required this.capacity,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final percent = capacity == 0 ? 0.0 : occupied / capacity;
    final freeSeats = capacity - occupied;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "OCCUPANCY",
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: .5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
              const Spacer(),
              const Icon(Icons.airline_seat_recline_normal,
                  size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(color: CustomColor.textPrimary(context)),
              children: [
                TextSpan(
                  text: "$occupied",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " / $capacity",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(Colors.indigo),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${(percent * 100).round()}% Loaded",
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
          Text(
            "$freeSeats Free Seats",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// LIVE SPEED CARD
/// =========================================================
class LiveSpeedCard extends StatelessWidget {
  final int speed;
  final String direction;
  final String location;

  const LiveSpeedCard({
    super.key,
    required this.speed,
    required this.direction,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "LIVE SPEED",
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: .5,
                  color: CustomColor.textSecondary(context),
                ),
              ),
              const Spacer(),
              const Icon(Icons.north, size: 12, color: Colors.green),
              const SizedBox(width: 2),
              Text(
                direction.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(color: CustomColor.textPrimary(context)),
              children: [
                TextSpan(
                  text: "$speed ",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "km/h",
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            location,
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// DRIVER STATE / BUS STATUS toggle-style card
/// =========================================================
class ToggleStatusCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData? footerIcon;
  final String footerText;
  final bool isOn;
  final ValueChanged<bool>? onChanged;

  const ToggleStatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.footerIcon,
    this.footerText = "",
    this.isOn = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: .5,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              Transform.scale(
                scale: .8,
                child: Switch(
                  value: isOn,
                  activeColor: Colors.green,
                  onChanged: onChanged ?? (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isOn ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
          if (footerText.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                if (footerIcon != null)
                  Icon(footerIcon, size: 13, color: Colors.green),
                if (footerIcon != null) const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    footerText,
                    style: const TextStyle(fontSize: 11, color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// =========================================================
/// ACTIVE TRIP CARD (redesigned to match screenshot)
/// =========================================================
class ActiveTripCard extends StatelessWidget {
  final String tripId;
  final String stopName;
  final String eta;
  final String distanceRemaining;
  final VoidCallback? onViewMap;
  final VoidCallback? onTripEnd;

  const ActiveTripCard({
    super.key,
    required this.tripId,
    required this.stopName,
    required this.eta,
    required this.distanceRemaining,
    this.onViewMap,
    this.onTripEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CustomColor.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "ACTIVE RUN IN PROGRESS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "TRIP #$tripId",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "NEXT WAYPOINT STOP",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: .5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stopName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "ETA $eta  •  $distanceRemaining remaining",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward,
                      color: CustomColor.primary, size: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onViewMap ?? () {},
                  icon: Icon(Icons.map, size: 18, color: CustomColor.primary),
                  label: Text(
                    "View Active Map",
                    style: TextStyle(
                      color: CustomColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(.15),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onTripEnd ?? () {},
                  icon: const Icon(Icons.flag, size: 18, color: Colors.white),
                  label: const Text(
                    "Trip End",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// COMMAND CARD (Transit Command shortcuts grid item)
/// =========================================================
class CommandCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback? onTap;

  const CommandCard({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CustomColor.card_bg(context),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(.15),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =========================================================
/// STATUS CARD (kept for backward compatibility)
/// =========================================================
class StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// MAP PREVIEW CARD (Corridor Elevation & Traffic)
/// =========================================================
class RouteStopPoint {
  final String name;
  final String time;
  final IconData icon;
  final Color color;

  const RouteStopPoint({
    required this.name,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class CorridorMapCard extends StatelessWidget {
  final String title;
  final String trafficStatus;
  final String liveLagText;
  final String totalDistanceText;
  final List<RouteStopPoint> stops;
  final String? mapImageUrl;

  const CorridorMapCard({
    super.key,
    required this.title,
    required this.trafficStatus,
    required this.liveLagText,
    required this.totalDistanceText,
    required this.stops,
    this.mapImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.alt_route, size: 18, color: Colors.indigo),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                trafficStatus,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Map placeholder area
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade100,
                        Colors.blue.shade50,
                      ],
                    ),
                  ),
                  child: mapImageUrl != null
                      ? Image.network(mapImageUrl!, fit: BoxFit.cover)
                      : const Center(
                    child: Icon(Icons.map_outlined,
                        size: 42, color: Colors.black26),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.circle,
                            size: 8, color: Colors.greenAccent),
                        const SizedBox(width: 5),
                        Text(
                          "Live Telematics $liveLagText",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      totalDistanceText,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Stops timeline row
          Row(
            children: List.generate(stops.length * 2 - 1, (i) {
              if (i.isOdd) {
                return const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(
                      thickness: 1.4,
                      color: Colors.black26,
                    ),
                  ),
                );
              }
              final stop = stops[i ~/ 2];
              return Column(
                children: [
                  Icon(stop.icon, size: 16, color: stop.color),
                  const SizedBox(height: 4),
                  Text(
                    stop.name,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  Text(
                    stop.time,
                    style: TextStyle(
                      fontSize: 10,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// =========================================================
/// TICKETING SYNC CARD
/// =========================================================
class TicketingSyncCard extends StatelessWidget {
  final String title;
  final int eTickets;
  final int cashBoardings;
  final VoidCallback? onManifest;

  const TicketingSyncCard({
    super.key,
    required this.title,
    required this.eTickets,
    required this.cashBoardings,
    this.onManifest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card_bg(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.confirmation_number,
                color: Colors.indigo, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "$eTickets e-Tickets Scanned • $cashBoardings Cash Boardings",
                  style: TextStyle(
                    fontSize: 11,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onManifest ?? () {},
            child: const Text(
              "Manifest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}



/// =========================================================
/// Below: original widgets kept for backward compatibility
/// (in case they're referenced elsewhere in the app)
/// =========================================================

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: CustomColor.textSecondary(context)),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const Spacer(),
          Text(
            subtitle,
            style: TextStyle(color: CustomColor.textSecondary(context)),
          ),
        ],
      ),
    );
  }
}

class RouteCard extends StatelessWidget {
  final String route;

  const RouteCard({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.navigation, color: CustomColor.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              route,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CustomColor.textPrimary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DriverActionCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;

  const DriverActionCard({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(0, 58),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CurrentStopCard extends StatelessWidget {
  final String stopName;
  final String time;
  final int occupancy;

  const CurrentStopCard({
    super.key,
    required this.stopName,
    required this.time,
    required this.occupancy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stopName,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: CustomColor.textPrimary(context),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: TextStyle(
              color: CustomColor.primary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: occupancy / 100,
            minHeight: 10,
            borderRadius: BorderRadius.circular(50),
          ),
        ],
      ),
    );
  }
}

class PassengerCounterCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const PassengerCounterCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(.12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const Spacer(),
            Text(
              "$count",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
                IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NextStopCard extends StatelessWidget {
  const NextStopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tankisinuwari Bus Stand",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Arrival in 6 min"),
        ],
      ),
    );
  }
}
/// Generic rounded card wrapper used across the screen
/// (stat cards, map card, timeline card, actions card).
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
/// One of the four stat cards: SPEED, PASSENGERS, DISTANCE REM., ETA.
class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget valueRow;
  final Widget? footer;
  final Widget? trailingBadge;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.valueRow,
    this.footer,
    this.trailingBadge,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 15, color: CustomColor.textMutedLabel(context)),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  ),
                ],
              ),
              if (trailingBadge != null) trailingBadge!,
            ],
          ),
          const SizedBox(height: 8),
          valueRow,
          if (footer != null) ...[
            const SizedBox(height: 8),
            footer!,
          ],
        ],
      ),
    );
  }
}

/// "LIMIT 50" style chip used inside the speed stat card.
class LimitBadge extends StatelessWidget {
  final int limit;
  const LimitBadge({super.key, required this.limit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: CustomColor.speedLimitBg(context),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'LIMIT $limit',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: CustomColor.speedLimitText(context),
        ),
      ),
    );
  }
}

/// Thin rounded progress bar for the speed card.
class SpeedProgressBar extends StatelessWidget {
  final double progress; // 0..1
  const SpeedProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress.clamp(0, 1),
        minHeight: 6,
        backgroundColor: CustomColor.speedProgressTrack(context),
        valueColor: const AlwaysStoppedAnimation(CustomColor.speedProgress),
      ),
    );
  }
}



// Map card: road-segment header + faux map surface + floating controls
/// + "NEXT DIRECTION" banner overlay.
///
/// Swap the placeholder [Container] inside for your real map widget
/// (google_maps_flutter / mapbox_gl / flutter_map, etc).
class MapCard extends StatelessWidget {
  final String roadSegment;
  final bool trafficSignalActive;
  final String nextDirectionText;
  final String nextDirectionDistance;
  final VoidCallback? onMyLocationTap;
  final VoidCallback? onTrafficToggle;
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  const MapCard({
    super.key,
    required this.roadSegment,
    required this.trafficSignalActive,
    required this.nextDirectionText,
    required this.nextDirectionDistance,
    this.onMyLocationTap,
    this.onTrafficToggle,
    this.onZoomIn,
    this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.mapSurface(context),
          border: Border.all(color: CustomColor.border(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: CustomColor.success),
                  const SizedBox(width: 6),
                  Text(
                    roadSegment,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: CustomColor.mapFill(context),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 48,
                        color: CustomColor.textMutedLabel(context).withOpacity(0.4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Column(
                      children: [
                        MapControlButton(
                          icon: Icons.my_location,
                          onTap: onMyLocationTap ?? () {},
                        ),
                        const SizedBox(height: 8),
                        MapControlButton(
                          icon: Icons.traffic,
                          active: trafficSignalActive,
                          onTap: onTrafficToggle ?? () {},
                        ),
                        const SizedBox(height: 8),
                        MapControlButton(icon: Icons.add, onTap: onZoomIn ?? () {}),
                        const SizedBox(height: 8),
                        MapControlButton(icon: Icons.remove, onTap: onZoomOut ?? () {}),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: NextDirectionBanner(
                      instruction: nextDirectionText,
                      distance: nextDirectionDistance,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Per-type visual styling (leading icon, avatar color, badge colors)
/// for a [NotificationItem].
class _NotifStyle {
  final IconData icon;
  final Color Function(BuildContext) avatarBg;
  final Color Function(BuildContext) badgeBg;
  final Color Function(BuildContext) badgeText;

  const _NotifStyle({
    required this.icon,
    required this.avatarBg,
    required this.badgeBg,
    required this.badgeText,
  });
}

_NotifStyle _styleFor(NotificationType type) {
  switch (type) {
    case NotificationType.emergency:
      return _NotifStyle(
        icon: Icons.warning_amber_rounded,
        avatarBg: (_) => CustomColor.notifEmergencyBg,
        badgeBg: CustomColor.notifEmergencyBadgeBg,
        badgeText: CustomColor.notifEmergencyBadgeText,
      );
    case NotificationType.routeUpdate:
      return _NotifStyle(
        icon: Icons.alt_route,
        avatarBg: (_) => CustomColor.notifRouteUpdateBg,
        badgeBg: CustomColor.notifRouteUpdateBadgeBg,
        badgeText: CustomColor.notifRouteUpdateBadgeText,
      );
    case NotificationType.rosterAssigned:
      return _NotifStyle(
        icon: Icons.event_available_outlined,
        avatarBg: (_) => CustomColor.notifRosterBg,
        badgeBg: CustomColor.notifRosterBadgeBg,
        badgeText: CustomColor.notifRosterBadgeText,
      );
    case NotificationType.resolved:
      return _NotifStyle(
        icon: Icons.build_circle_outlined,
        avatarBg: CustomColor.notifResolvedBg,
        badgeBg: CustomColor.notifResolvedBadgeBg,
        badgeText: CustomColor.notifResolvedBadgeText,
      );
    case NotificationType.recognition:
      return _NotifStyle(
        icon: Icons.workspace_premium_outlined,
        avatarBg: (_) => CustomColor.notifRecognitionBg,
        badgeBg: CustomColor.notifRecognitionBadgeBg,
        badgeText: CustomColor.notifRecognitionBadgeText,
      );
  }
}

/// One notification card in the feed.
class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback? onExpandToggle;

  const NotificationCard({super.key, required this.item, this.onExpandToggle});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(item.type);

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LeadingAvatar(
            icon: style.icon,
            bgColor: style.avatarBg(context),
            isUnread: item.isUnread,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: style.badgeBg(context),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.badgeLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          color: style.badgeText(context),
                        ),
                      ),
                    ),
                    if (item.priorityLabel != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        item.priorityLabel!,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: CustomColor.notifPriorityText,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      item.timeLabel,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: item.isExpanded ? null : 2,
                  overflow: item.isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: onExpandToggle,
                  child: Row(
                    children: [
                      Icon(item.sourceIcon, size: 14, color: CustomColor.textMutedLabel(context)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.sourceLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColor.textMutedLabel(context),
                          ),
                        ),
                      ),
                      Icon(
                        item.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 18,
                        color: CustomColor.textMutedLabel(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Leading circular icon avatar with a small unread/read status dot.
class _LeadingAvatar extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final bool isUnread;

  const _LeadingAvatar({
    required this.icon,
    required this.bgColor,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          Positioned(
            right: -1,
            top: -1,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isUnread ? CustomColor.notifUnreadDot : CustomColor.notifReadDot(context),
                shape: BoxShape.circle,
                border: Border.all(color: CustomColor.card(context), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// Generic rounded section card wrapper used across the screen
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: CustomColor.shadow(context),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Generic rounded section card wrapper (reused style)
class EmergencySectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const EmergencySectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
        boxShadow: [
          BoxShadow(
            color: CustomColor.shadow(context),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
/// "Instant Network Escalation" info card with rich text description
class NetworkEscalationCard extends StatelessWidget {
  const NetworkEscalationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CustomColor.emergencyRedTint(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CustomColor.emergencyRedTintBorder(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: const BoxDecoration(
              color: CustomColor.emergencyRedLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.podcasts_rounded,
                size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instant Network Escalation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: CustomColor.textSecondary(context),
                    ),
                    children: const [
                      TextSpan(
                          text:
                          'Triggering SOS simultaneously broadcasts calibrated GNSS telemetry, passenger manifest ('),
                      TextSpan(
                        text: '32 souls',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: CustomColor.emergencyRedLight,
                        ),
                      ),
                      TextSpan(
                          text:
                          '), and active vehicle status directly to Koshi Dispatch, Nepal Police (100), and highway patrol.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/// "Dispatch Operations Screen Preview" card with priority ticket
class DispatchPreviewCard extends StatelessWidget {
  final PriorityTicket ticket;

  const DispatchPreviewCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return EmergencySectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.desktop_windows_outlined,
                        size: 16, color: CustomColor.textSecondary(context)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'DISPATCH OPERATIONS SCREEN PREVIEW',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColor.queueBadgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ticket.queueLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.queueBadgeText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomColor.priorityTicketBg(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CustomColor.border(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: CustomColor.danger),
                        const SizedBox(width: 6),
                        Text(
                          'PRIORITY TICKET #${ticket.ticketId}',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: CustomColor.textPrimary(context),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      ticket.timeAgo,
                      style: TextStyle(
                          fontSize: 11, color: CustomColor.textSecondary(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Target: ${ticket.targetLabel}',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    _StatusCheck(
                        label: 'GPS Sync OK', ok: ticket.gpsSync),
                    _StatusCheck(
                        label: '${ticket.passengerCount} Pax Tagged',
                        ok: ticket.passengersTagged),
                    _StatusCheck(
                        label: 'Tow Alert Sent', ok: ticket.towAlertSent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCheck extends StatelessWidget {
  final String label;
  final bool ok;
  const _StatusCheck({required this.label, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.cancel,
          size: 13,
          color: ok ? CustomColor.success : CustomColor.danger,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: CustomColor.textSecondary(context),
          ),
        ),
      ],
    );
  }
}



/// Generic rounded surface card used for all white/dark content blocks.
class AppCard1 extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const AppCard1({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: child,
    );
  }
}

// Message bubble from the ops/dispatch desk shown on the incident card.
class DispatchMessageCard extends StatelessWidget {
  final String author;
  final String message;

  const DispatchMessageCard({
    super.key,
    required this.author,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CustomColor.dispatchMessageBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: CustomColor.dispatchAvatarBg(context),
            child: Icon(Icons.headset_mic_outlined,
                size: 16, color: CustomColor.iconMuted(context)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One tile in the top 2x2 summary stats grid.
class SummaryStatCard extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String label;
  final String value;
  final String? unit;
  final String subtext;

  const SummaryStatCard({
    super.key,
    required this.icon,
    required this.accent,
    required this.label,
    required this.value,
    required this.subtext,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: CustomColor.statIconBg(context, accent),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textSecondary(context),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtext,
            style: TextStyle(
              fontSize: 11,
              color: CustomColor.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
// Stylised map preview used for the "GPS Telemetry Path Trace" section.
/// Uses a gradient placeholder (no real map SDK) with overlay badges for
/// the verified-route indicator and max speed reading.
class MapPreviewCard extends StatelessWidget {
  final String bottomLeftLabel;
  final String bottomRightLabel;

  const MapPreviewCard({
    super.key,
    required this.bottomLeftLabel,
    required this.bottomRightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [CustomColor.mapBgStart, CustomColor.mapBgEnd],
                ),
              ),
            ),
            const Center(
              child: Icon(Icons.map_outlined,
                  size: 36, color: CustomColor.mapPlaceholderIcon),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: CustomColor.mapOverlayBadgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: CustomColor.mapVerifiedDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      bottomLeftLabel,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.mapOverlayText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: CustomColor.mapOverlayBadgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  bottomRightLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.mapOverlayText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// A collapsed trip manifest row (used for older/completed trips).
class CompactManifestCard extends StatelessWidget {
  final CompactManifest manifest;
  final VoidCallback onDetailsTap;

  const CompactManifestCard({
    super.key,
    required this.manifest,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              OutlineChip(label: manifest.tripId),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  manifest.dateLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              InfoBadge(
                label: manifest.statusLabel,
                icon: Icons.check_circle,
                background: CustomColor.badgeGreenBg(context),
                foreground: CustomColor.badgeGreenText(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  manifest.routeTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Text(
                manifest.distanceLogged,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            manifest.timeRangeSubtitle,
            style: TextStyle(
              fontSize: 12,
              color: CustomColor.textSecondary(context),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(manifest.leftIcon,
                  size: 14, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 4),
              Text(
                manifest.leftLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: CustomColor.textSecondary(context),
                ),
              ),
              const SizedBox(width: 14),
              Icon(manifest.midIcon,
                  size: 14, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 4),
              Text(
                manifest.midLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: CustomColor.textSecondary(context),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onDetailsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.primary,
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        size: 16, color: CustomColor.primary),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// The fully-expanded featured manifest card at the top of the list.
class DetailedManifestCard extends StatelessWidget {
  final DetailedManifest manifest;
  final VoidCallback onViewManifest;
  final VoidCallback onShare;

  const DetailedManifestCard({
    super.key,
    required this.manifest,
    required this.onViewManifest,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              OutlineChip(label: manifest.tripId),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  manifest.dateShift,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              InfoBadge(
                label: manifest.statusLabel,
                icon: Icons.check_circle,
                background: CustomColor.badgeGreenBg(context),
                foreground: CustomColor.badgeGreenText(context),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: CustomColor.bg_color(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  manifest.plateNumber,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  manifest.busType,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              Text(
                manifest.tripLogId,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11,
                  color: CustomColor.textMutedLabel(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RouteTimeline(origin: manifest.origin, destination: manifest.destination),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: MiniStatTile(label: 'Duration', value: manifest.duration),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MiniStatTile(label: 'Distance', value: manifest.distance),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MiniStatTile(label: 'Avg Speed', value: manifest.avgSpeed),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.check_circle_outline,
                  size: 16, color: CustomColor.success),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  manifest.stopsCoveredLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Icon(Icons.groups_outlined,
                  size: 14, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 4),
              Text(
                manifest.loadLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                'GPS Telemetry Path Trace',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
              const Spacer(),
              Icon(Icons.alt_route, size: 13, color: CustomColor.primary),
              const SizedBox(width: 4),
              Text(
                manifest.highwayLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MapPreviewCard(
            bottomLeftLabel: manifest.routeLogLabel,
            bottomRightLabel: manifest.maxSpeedLabel,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: onViewManifest,
                    icon: Icon(Icons.description_outlined,
                        size: 16, color: CustomColor.textPrimary(context)),
                    label: Text(
                      'View Manifest',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.textPrimary(context),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: CustomColor.border(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onShare,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: CustomColor.squareButtonBg(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CustomColor.squareButtonBorder(context)),
                  ),
                  child: Icon(Icons.share_outlined,
                      size: 18, color: CustomColor.textPrimary(context)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/// Dark gradient promo card showing the user's daily-commute route,
/// next departure ETA, and a live position progress bar.
class RoutePromoCard extends StatelessWidget {
  final RoutePromoData data;
  final VoidCallback onQuickTrack;

  const RoutePromoCard({
    super.key,
    required this.data,
    required this.onQuickTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColor.routeCardGradientStart,
            CustomColor.routeCardGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Pill(text: data.routeNumber, bold: true),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.tag,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: CustomColor.onDarkMuted,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.confirmation_num_outlined,
                      size: 12, color: CustomColor.onDark),
                  const SizedBox(width: 4),
                  _Pill(text: data.fare, bold: true),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            data.stopName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: CustomColor.onDark,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: CustomColor.onlineDot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.etaLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CustomColor.onDarkMuted,
                  ),
                ),
              ),
              SizedBox(
                height: 38,
                child: ElevatedButton.icon(
                  onPressed: onQuickTrack,
                  icon: const Icon(Icons.my_location,
                      size: 15, color: CustomColor.routeQuickTrackText),
                  label: const Text(
                    'Quick Track',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.routeQuickTrackText,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.routeQuickTrackBg,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                data.fromStop,
                style: const TextStyle(fontSize: 10, color: CustomColor.onDarkMuted),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: CustomColor.routeProgressTrack,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final dotX =
                            (constraints.maxWidth - 14) * data.progress.clamp(0, 1);
                        return Padding(
                          padding: EdgeInsets.only(left: dotX),
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: CustomColor.routeProgressFill,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.directions_bus,
                                size: 9, color: CustomColor.primary),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                data.toStop,
                style: const TextStyle(fontSize: 10, color: CustomColor.onDarkMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final bool bold;
  const _Pill({required this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColor.routeCardBadgeBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          color: CustomColor.routeCardBadgeText,
        ),
      ),
    );
  }
}
/// Dark "Live Highway Radar" map placeholder with an active-count badge,
/// a recenter button, and a bottom overlay bar for highway/speed stats.
class LiveRadarCard extends StatelessWidget {
  final String activeLabel;
  final String highwayLabel;
  final String speedLabel;
  final VoidCallback onRecenter;

  const LiveRadarCard({
    super.key,
    required this.activeLabel,
    required this.highwayLabel,
    required this.speedLabel,
    required this.onRecenter,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [CustomColor.radarBgStart, CustomColor.radarBgEnd],
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: CustomColor.radarActiveDot,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    activeLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.radarOverlayText,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: InkWell(
                onTap: onRecenter,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: CustomColor.radarOverlayBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.my_location,
                      size: 16, color: CustomColor.radarOverlayText),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: CustomColor.radarOverlayBg,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        highwayLabel,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.radarOverlayText,
                        ),
                      ),
                    ),
                    Text(
                      speedLabel,
                      style: const TextStyle(
                        fontSize: 11,
                        color: CustomColor.radarOverlayText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/// One nearby real-time bus card. Renders either the full "active" layout
/// (nearest stop + capacity + search_route button) or the compact "maintenance"
/// layout (a single warning row, no search_route button).
class LiveBusCard extends StatelessWidget {
  final LiveBus bus;
  final bool isBookmarked;
  final VoidCallback onTrack;
  final VoidCallback onBookmarkToggle;

  const LiveBusCard({
    super.key,
    required this.bus,
    required this.isBookmarked,
    required this.onTrack,
    required this.onBookmarkToggle,
  });

  bool get _isActive => bus.status == BusStatus.active;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            bus.plateNumber,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: CustomColor.textPrimary(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InfoBadge(
                          label: _isActive ? 'ACTIVE' : 'MAINTENANCE',
                          icon: _isActive ? Icons.circle : Icons.build_outlined,
                          background: _isActive
                              ? CustomColor.statusActiveBg(context)
                              : CustomColor.statusMaintenanceBg(context),
                          foreground: _isActive
                              ? CustomColor.statusActiveText(context)
                              : CustomColor.statusMaintenanceText(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      bus.routeTitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: CustomColor.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bus.etaValue,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _isActive
                          ? CustomColor.etaActiveColor
                          : CustomColor.etaDelayedColor(context),
                    ),
                  ),
                  Text(
                    bus.etaUnit,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textMutedLabel(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_isActive) ..._activeBody(context) else ..._maintenanceBody(context),
        ],
      ),
    );
  }

  List<Widget> _activeBody(BuildContext context) {
    return [
      Row(
        children: [
          Icon(Icons.location_on_outlined,
              size: 14, color: CustomColor.iconMuted(context)),
          const SizedBox(width: 4),
          Text(
            'Nearest Stop: ${bus.nearestStop}',
            style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
          ),
          const Spacer(),
          Text(
            bus.nearestStopDistance ?? '',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Icon(Icons.groups_outlined, size: 14, color: CustomColor.iconMuted(context)),
          const SizedBox(width: 4),
          Text(
            'Capacity: ${bus.capacityCurrent}/${bus.capacityMax} Seats',
            style: TextStyle(fontSize: 12, color: CustomColor.textSecondary(context)),
          ),
          const Spacer(),
          Text(
            bus.capacityNote ?? '',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: CustomColor.textPrimary(context),
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      CapacityBar(percent: bus.capacityPercent ?? 0),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onTrack,
                icon: const Icon(Icons.navigation_outlined,
                    size: 16, color: CustomColor.onDark),
                label: const Text(
                  'Track Live Bus',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.onDark,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _BookmarkButton(isBookmarked: isBookmarked, onTap: onBookmarkToggle),
        ],
      ),
    ];
  }

  List<Widget> _maintenanceBody(BuildContext context) {
    return [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomColor.warningRowBg(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, size: 15, color: CustomColor.warningRowIcon),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                bus.warningText ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: CustomColor.warningRowText(context),
                ),
              ),
            ),
            Text(
              '${bus.capacityCurrent}/${bus.capacityMax} seats',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: CustomColor.warningRowText(context),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}

class _BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onTap;

  const _BookmarkButton({required this.isBookmarked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: CustomColor.squareButtonBg(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CustomColor.squareButtonBorder(context)),
        ),
        child: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          size: 18,
          color: isBookmarked ? CustomColor.primary : CustomColor.textSecondary(context),
        ),
      ),
    );
  }
}



/// Light blue card showing the passenger's auto-detected GPS coordinates.
class GpsCoordinatesCard extends StatelessWidget {
  final String label;
  final String coordinates;
  final String subtext;

  const GpsCoordinatesCard({
    super.key,
    required this.label,
    required this.coordinates,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CustomColor.gpsCardBg(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.gps_fixed, size: 18, color: CustomColor.gpsCardIcon(context)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  coordinates,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.near_me_outlined,
                        size: 12, color: CustomColor.textSecondary(context)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        subtext,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: CustomColor.textSecondary(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// Card showing the dispatch unit, protocol, and registered family alert
/// status, with a footer link to dispatch settings.
class DispatchPreviewCard1 extends StatelessWidget {
  final String title;
  final List<DispatchInfoRow> rows;
  final String channelLabel;
  final VoidCallback onSettingsTap;

  const DispatchPreviewCard1({
    super.key,
    required this.title,
    required this.rows,
    required this.channelLabel,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user_outlined,
                  size: 18, color: CustomColor.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColor.monitoredBadgeBg(context),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'MONITORED 24/7',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: CustomColor.monitoredBadgeText,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: CustomColor.border(context)),
          ),
          for (final row in rows) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      row.label,
                      style: TextStyle(
                        fontSize: 11,
                        color: CustomColor.dispatchRowLabel(context),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (row.leadingIcon != null) ...[
                          Icon(row.leadingIcon, size: 13, color: CustomColor.success),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            row.value,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: row.isLink
                                  ? CustomColor.dispatchLinkValue(context)
                                  : CustomColor.dispatchRowValue(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(height: 1, color: CustomColor.border(context)),
          ),
          Row(
            children: [
              Icon(Icons.lock_outline,
                  size: 13, color: CustomColor.channelLockIcon(context)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  channelLabel,
                  style: TextStyle(
                    fontSize: 11,
                    color: CustomColor.textSecondary(context),
                  ),
                ),
              ),
              InkWell(
                onTap: onSettingsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Dispatch settings',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.primary,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 15, color: CustomColor.primary),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


