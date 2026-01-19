import 'package:flutter/material.dart';

class Toastmassage {
  static void _showToast(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          elevation: 6, // Saadullah,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white), // ✅ real white icon
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static void successToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.black,
      icon: Icons.info,
    );
  }

  static void errorToast(BuildContext context, Object? error) {
    _showToast(
      context,
      error.toString(),
      backgroundColor: Colors.red,

      icon: Icons.error,
    );
  }

  static void generalToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.teal,
      icon: Icons.info_outline,
    );
  }

  static void warningToast(BuildContext context, String msg) {
    _showToast(
      context,
      msg,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }
}
