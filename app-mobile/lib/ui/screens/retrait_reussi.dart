import 'package:epargne_collective/ui/screens/home_screen.dart';
import 'package:epargne_collective/ui/screens/nav_bottom.dart';
import 'package:epargne_collective/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RetraitReussi extends StatefulWidget {
  const RetraitReussi({super.key});

  @override
  State<RetraitReussi> createState() => _RetraitReussiState();
}

class _RetraitReussiState extends State<RetraitReussi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/success.jpg",
                height: 220,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Votre demande de retrait a bien été receptionné. Les fonds vous seront envoyés sous quelques heures.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const Bottom();
                    }));
                  },
                  elevation: 0,
                  fillColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    "Retour à l'écran d'accueil",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
