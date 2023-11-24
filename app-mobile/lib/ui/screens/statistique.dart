import 'package:epargne_collective/Models/statistique.dart';
import 'package:epargne_collective/Models/transaction.dart';
import 'package:epargne_collective/repositories/data_repository.dart';
import 'package:epargne_collective/ui/widgets/appbar_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Statistique extends StatefulWidget {
  const Statistique({super.key});

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  List<TransactionModel> transactionsList = [];
// Map pour stocker le total des dépôts par mois
  Map<String, int> totalDepositsByMonth = {};

  // Compte le nombre de dépôts par mois
  Map<String, int> depositCountByMonth = {};

  late List<StatistiqueModel> graphes;
  bool isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    setState(() {}); //Pour reconstruire la page quand on vient sur ça
    if (!isDataInitialized) {
      initData();
      isDataInitialized = true;
    }
  }

  Future<void> initData() async {
    try {
      final dataProvider = Provider.of<DataRepository>(context, listen: false);
      transactionsList = dataProvider.transactionsList;

      // Boucle à travers les transactions pour agréger les données
      for (TransactionModel transaction in transactionsList) {
        // Convertit la date de la transaction en un mois (format 'MM-yyyy')
        DateTime transactionDate =
            transaction.date!.toDate(); // Convertit le Timestamp en DateTime
        String monthYear = "${transactionDate.month}-${transactionDate.year}";

        // Met à jour le total des dépôts par mois
        totalDepositsByMonth.update(
          monthYear,
          (value) => value + transaction.montant,
          ifAbsent: () => transaction.montant,
        );

        // Met à jour le nombre de dépôts par mois
        depositCountByMonth.update(
          monthYear,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }

      // Transforme les données en une liste de TransactionData
      List<StatistiqueModel> data = totalDepositsByMonth.entries.map((entry) {
        String month = entry.key;
        int totalDepositAmount = entry.value;
        print(totalDepositAmount);

        int depositCount = depositCountByMonth[month] ?? 0;

        return StatistiqueModel(month, totalDepositAmount, depositCount);
      }).toList();

      // Trie les données par mois
      data.sort((a, b) => a.month.compareTo(b.month));

      graphes = data;
    } catch (e) {
      print("Erreur home : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Statistique"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(graphes.length, (index) {
                  return FlSpot(index.toDouble(),
                      graphes[index].depositAmount.toDouble());
                }),
                isCurved: true,
                // belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
