import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceBox extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onPressed;
  final Key? key;

  const ServiceBox({required this.image, required this.onPressed,required this.label, this.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 80,                        
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: Image.asset(
              image,
              width: 50,
              height: 50,                           
            ),
          ),
          const SizedBox(height: 10), 
          Container(
            width: 100,
            padding: const EdgeInsets.all(8),           
            child:  Text(
              label,              
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.secularOne(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),              
            ),
          ),
        ],
      ),
    );
  }
}
