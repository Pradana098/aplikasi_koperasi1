import 'package:flutter/material.dart';

class ProfilSelamatDatangWidget extends StatelessWidget {
  final String? photoUrl;
  final String nama;
  final VoidCallback? onNotificationTap;

  const ProfilSelamatDatangWidget({
    super.key,
    required this.photoUrl,
    required this.nama,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                backgroundImage: photoUrl != null && photoUrl?.isNotEmpty == true
                    ? NetworkImage(photoUrl!)
                    : const AssetImage('assets/img/default_avatar.png') as ImageProvider,
                child: photoUrl == null || photoUrl?.isEmpty == true
                    ? const Icon(Icons.person, color: Colors.white, size: 24)
                    : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.notifications_outlined, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}