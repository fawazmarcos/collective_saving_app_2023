import 'package:epargne_collective/Models/demande_retrait.dart';
import 'package:epargne_collective/Models/transaction.dart';
import 'package:epargne_collective/repositories/data_repository.dart';
import 'package:epargne_collective/ui/screens/demande_retrait.dart';
import 'package:epargne_collective/ui/widgets/appbar_widget.dart';
import 'package:epargne_collective/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoriqueDemandeRetrait extends StatefulWidget {
  String? idSouscription;
  HistoriqueDemandeRetrait({
    Key? key,
    this.idSouscription,
  }) : super(key: key);

  @override
  State<HistoriqueDemandeRetrait> createState() =>
      _HistoriqueDemandeRetraitState();
}

class _HistoriqueDemandeRetraitState extends State<HistoriqueDemandeRetrait> {
  String idSouscription = "";
  List<DemandeRetraitModel> demandesRetraitList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idSouscription = widget.idSouscription ?? "";
    initData();
  }

  Future<void> initData() async {
    try {
      final dataProvider = Provider.of<DataRepository>(context, listen: false);
      demandesRetraitList = idSouscription.isNotEmpty
          ? dataProvider.demandesRetraitList
              .where((element) => element.idSouscription == idSouscription)
              .toList()
          : dataProvider.demandesRetraitList;
    } catch (e) {
      print("Erreur home : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Historique transactions",
      ),
      body: SingleChildScrollView(
        child: demandesRetraitList.isEmpty
            ? Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Aucune demandes de retrait effectuées",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: blackColor),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: demandesRetraitList.length,
                itemBuilder: (BuildContext context, int index) {
                  return get(demandesRetraitList[index], index);
                }),
      ),
    );
  }

  ListTile get(DemandeRetraitModel demandeRetrait, int index) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Icon(
          Icons.payments,
          size: 40,
          color: primaryColor,
        ),
      ),
      title: Text(
        "Date: ${demandeRetrait.createdAt}",
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        demandeRetrait.traitement == 0 ? "Non traité" : "Traité",
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color:
                demandeRetrait.traitement == 0 ? primaryColor : Colors.green),
      ),
      trailing: Text(
        demandeRetrait.montant == null
            ? "0"
            : "${demandeRetrait.montant.toString()} CFA",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 19,
        ),
      ),
    );
  }
}
