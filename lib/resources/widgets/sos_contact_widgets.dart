import 'package:flutter/material.dart';
import '../../providers/passenger_provider/sos_contact_provider.dart';
import '../color/custom_color.dart';


/// ---------------------------------------------------------------------
/// PassengerSosResources
/// All the small reusable pieces (banners / cards / tiles / chips /
/// avatars) used to build the Passenger SOS "Trusted Safety Circle"
/// screen, kept together in one file as requested.
/// ---------------------------------------------------------------------

/// Top hero banner: "Trusted Safety Circle  [Active]" description card.
class TrustedSafetyCircleBanner extends StatelessWidget {
  const TrustedSafetyCircleBanner({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.heroBannerBg(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomColor.heroIconBg(context),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield, color: Colors.white, size: 20),
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
                        'Trusted Safety Circle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: CustomColor.textPrimary(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusPill(
                      label: isActive ? 'Active' : 'Inactive',
                      bg: isActive
                          ? CustomColor.greenBadgeBg
                          : CustomColor.border(context),
                      textColor: isActive
                          ? CustomColor.greenBadgeText
                          : CustomColor.textSecondary(context),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'These contacts receive automated SMS with your live GPS '
                      'link whenever you press the Emergency SOS button.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: CustomColor.textMutedLabel(context),
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

/// Small rounded status pill, e.g. "Active", "Primary", "Father".
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    required this.bg,
    required this.textColor,
  });

  final String label;
  final Color bg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

/// Section header row, e.g. "Configured Contacts  2" ...... "Max 5 Trusted"
class SectionHeaderRow extends StatelessWidget {
  const SectionHeaderRow({
    super.key,
    required this.title,
    required this.count,
    required this.trailingLabel,
  });

  final String title;
  final int count;
  final String trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: CustomColor.textPrimary(context),
          ),
        ),
        const SizedBox(width: 8),
        StatusPill(
          label: '$count',
          bg: CustomColor.secondaryBlue,
          textColor: CustomColor.primary,
        ),
        const Spacer(),
        Text(
          trailingLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
      ],
    );
  }
}

/// Avatar circle with initials + a small overlay badge icon
/// (star for primary contact, heart for others).
class ContactAvatar extends StatelessWidget {
  const ContactAvatar({
    super.key,
    required this.initials,
    required this.bgColor,
    required this.badgeIcon,
    required this.badgeColor,
  });

  final String initials;
  final Color bgColor;
  final IconData badgeIcon;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: bgColor,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: CustomColor.card(context),
                  width: 2,
                ),
              ),
              child: Icon(badgeIcon, size: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// A small circular icon-button used for call / edit / delete actions.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final Color background;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, size: 17, color: iconColor),
      ),
    );
  }
}

/// Card that renders a single configured emergency contact, matching
/// the mock: avatar, name, relationship/primary chips, phone number,
/// alert-mode row and call/edit/delete actions.
class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contact,
    required this.onCall,
    required this.onEdit,
    required this.onDelete,
  });

  final EmergencyContact contact;
  final VoidCallback onCall;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ({Color bg, Color text}) _relationshipColors() {
    switch (contact.relationship.toLowerCase()) {
      case 'father':
      case 'mother':
      case 'guardian':
        return (
        bg: CustomColor.blueBadgeBg,
        text: CustomColor.blueBadgeText,
        );
      case 'sister':
      case 'brother':
        return (
        bg: CustomColor.pinkBadgeBg,
        text: CustomColor.pinkBadgeText,
        );
      default:
        return (bg: CustomColor.secondaryBlue, text: CustomColor.primary);
    }
  }

  Color _avatarColor() {
    switch (contact.relationship.toLowerCase()) {
      case 'sister':
      case 'brother':
        return CustomColor.teal;
      default:
        return CustomColor.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final relColors = _relationshipColors();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContactAvatar(
                initials: contact.initials,
                bgColor: _avatarColor(),
                badgeIcon: contact.isPrimary ? Icons.star : Icons.favorite,
                badgeColor:
                contact.isPrimary ? CustomColor.greenDark : CustomColor.pink,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.tileTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        StatusPill(
                          label: contact.relationship,
                          bg: relColors.bg,
                          textColor: relColors.text,
                        ),
                        if (contact.isPrimary)
                          StatusPill(
                            label: 'Primary',
                            bg: CustomColor.greenBadgeBg,
                            textColor: CustomColor.greenBadgeText,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              RoundIconButton(
                icon: Icons.call,
                background: CustomColor.callIconBg(context),
                iconColor: CustomColor.primary,
                onTap: onCall,
              ),
              const SizedBox(width: 8),
              RoundIconButton(
                icon: Icons.edit,
                background: CustomColor.editIconBg(context),
                iconColor: CustomColor.textSecondary(context),
                onTap: onEdit,
              ),
              const SizedBox(width: 8),
              RoundIconButton(
                icon: Icons.delete_outline,
                background: CustomColor.deleteIconBg(context),
                iconColor: CustomColor.danger,
                onTap: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.phone_iphone,
                  size: 15, color: CustomColor.iconMuted(context)),
              const SizedBox(width: 6),
              Text(
                contact.phone,
                style: TextStyle(
                  fontSize: 13,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: CustomColor.success,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                contact.alertMode.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.textSecondary(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A simple labelled text field used inside the "Add Emergency Contact"
/// form card.
class SosTextField extends StatelessWidget {
  const SosTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.prefixText,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final String? prefixText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: CustomColor.textPrimary(context)),
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColor.inputBg(context),
            hintText: hint,
            hintStyle: TextStyle(color: CustomColor.inputHintDefault(context)),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: CustomColor.iconMuted(context))
                : null,
            prefixText: prefixText,
            prefixStyle: TextStyle(color: CustomColor.textPrimary(context)),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: CustomColor.inputBorderDefault(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: CustomColor.inputBorderDefault(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: CustomColor.primary, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}

/// Relationship dropdown field.
class SosRelationshipDropdown extends StatelessWidget {
  const SosRelationshipDropdown({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final List<String> options;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Relationship',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColor.textMutedLabel(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: CustomColor.inputBg(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: CustomColor.inputBorderDefault(context)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Row(
                children: [
                  Icon(Icons.people_outline,
                      size: 18, color: CustomColor.iconMuted(context)),
                  const SizedBox(width: 10),
                  Text('Select relationship...',
                      style: TextStyle(
                          color: CustomColor.inputHintDefault(context))),
                ],
              ),
              icon: Icon(Icons.keyboard_arrow_down,
                  color: CustomColor.iconMuted(context)),
              dropdownColor: CustomColor.card(context),
              items: options
                  .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r,
                    style:
                    TextStyle(color: CustomColor.textPrimary(context))),
              ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

/// The full "Add Emergency Contact" form card.
class AddContactFormCard extends StatelessWidget {
  const AddContactFormCard({
    super.key,
    required this.provider,
    required this.onSubmit,
  });

  final PassengerSosContactProvider provider;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_add_alt_1, color: CustomColor.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Add Emergency Contact',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
              ),
              Icon(Icons.verified_user, color: CustomColor.success, size: 20),
            ],
          ),
          const SizedBox(height: 18),
          SosTextField(
            label: 'Full Name',
            controller: provider.nameController,
            hint: 'e.g. Sunil Thapa',
            prefixIcon: Icons.badge_outlined,
          ),
          const SizedBox(height: 16),
          SosTextField(
            label: 'Mobile Number',
            controller: provider.phoneController,
            hint: '98XXXXXXXX',
            prefixText: '+977   ',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          SosRelationshipDropdown(
            options: provider.relationshipOptions,
            value: provider.selectedRelationship,
            onChanged: provider.setRelationship,
          ),
          if (provider.formError != null) ...[
            const SizedBox(height: 10),
            Text(
              provider.formError!,
              style: const TextStyle(color: CustomColor.danger, fontSize: 12),
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.add_circle_outline, size: 20),
              label: const Text(
                'Add New Trusted Contact',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Verified by Nepal Police Highway Safety Protocol" strip.
class VerifiedByBanner extends StatelessWidget {
  const VerifiedByBanner({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: CustomColor.verifiedBg(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: CustomColor.verifiedText1(context), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: CustomColor.verifiedText1(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Test Alert Dispatch" card with a "Test Link" action button.
class TestAlertDispatchCard extends StatelessWidget {
  const TestAlertDispatchCard({
    super.key,
    required this.onTestLink,
    this.isLoading = false,
  });

  final VoidCallback onTestLink;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColor.card(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColor.border(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomColor.testAlertIconBg1(context),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.wb_sunny_outlined,
                color: CustomColor.testAlertIcon1(context), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test Alert Dispatch',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Send a trial SOS link to verify delivery',
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.textMutedLabel(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: isLoading ? null : onTestLink,
            style: OutlinedButton.styleFrom(
              foregroundColor: CustomColor.primary,
              side: const BorderSide(color: CustomColor.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            child: isLoading
                ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Text('Test Link',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

/// Top app header used on the Profile screen: brand row + notification
/// bell (with unread dot) + user avatar. Bottom navigation is
/// intentionally NOT included here — it's provided by the host screen.
class PassengerSosTopBar extends StatelessWidget {
  const PassengerSosTopBar({
    super.key,
    required this.onNotificationsTap,
    required this.onProfileTap,
    this.hasUnreadNotifications = true,
    this.avatarUrl,
  });

  final VoidCallback onNotificationsTap;
  final VoidCallback onProfileTap;
  final bool hasUnreadNotifications;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.card(context),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CustomColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_bus, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NVTS TRANSIT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: CustomColor.primary,
                ),
              ),
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: onNotificationsTap,
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.notifications_none,
                      color: CustomColor.textPrimary(context)),
                ),
                if (hasUnreadNotifications)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: CustomColor.notificationDot1(context),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: CustomColor.card(context), width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(24),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: CustomColor.secondaryBlue,
              backgroundImage:
              avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: avatarUrl == null
                  ? Icon(Icons.person, color: CustomColor.primary)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}