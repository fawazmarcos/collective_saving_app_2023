import 'package:epargne_collective/ui/screens/epargne.dart';
import 'package:epargne_collective/ui/screens/home_screen.dart';
import 'package:epargne_collective/ui/screens/login.dart';
import 'package:epargne_collective/ui/screens/paiement.dart';
import 'package:epargne_collective/ui/screens/parametre.dart';
import 'package:epargne_collective/ui/screens/statistique.dart';
import 'package:epargne_collective/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int indexColor = 0;
  List screen = [
    const HomeScreen(),
    const Epargne(),
    const Statistique(),
    const Parametre()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexColor],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              backgroundColor: Colors.white,
              color: primaryColor,
              tabBackgroundColor: secondaryColor,
              padding: const EdgeInsets.all(16),
              gap: 8,
              onTabChange: ((value) => setState(() {
                    indexColor = value;
                  })),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Accueil',
                ),
                GButton(
                  icon: Icons.payment,
                  text: 'Epargne',
                ),
                GButton(
                  icon: Icons.auto_graph,
                  text: 'Statistique',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Paramètre',
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Paiement()));
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
