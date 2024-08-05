import 'package:flutter/material.dart';

Widget ReusableImageLoginButton({
  required String imagePath,
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
      foregroundColor: Colors.white,
      side: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
      minimumSize: const Size(double.infinity, 50),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 25, width: 25),
        const SizedBox(height: 15, width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
