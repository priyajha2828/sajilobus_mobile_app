import 'package:flutter/material.dart';
import '../../providers/driver_provider/notifications_provider.dart';
import '../../providers/driver_provider/sos_provider.dart';
import '../banner/driver_banner.dart';
import '../bottom/driver_button.dart';
import '../color/custom_color.dart';

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
                    backgroundImage: NetworkImage(photoUrl),
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

