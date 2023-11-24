import 'package:epargne_collective/ui/widgets/appbar_widget.dart';
import 'package:epargne_collective/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreerTypeEpargne extends StatefulWidget {
  const CreerTypeEpargne({super.key});

  @override
  State<CreerTypeEpargne> createState() => _CreerTypeEpargneState();
}

class _CreerTypeEpargneState extends State<CreerTypeEpargne> {
  late String typeEpargne;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget submitButton = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Créer",
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.0),
      ),
    ],
  );
  //Bouton appelé lorsque login échoué
  Widget submitAgain = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Créer",
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.0),
      ),
    ],
  );
  //Bouton appelé lorsque traitement en couors
  Widget afterSubmit = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SpinKitCircle(color: Colors.white, size: 30),
      const SizedBox(
        width: 5.0,
      ),
      Text(
        "Patientez...",
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.0),
      )
    ],
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: "Création épargne",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTypeEpargneField(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildSubmitButtonField()
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTypeEpargneField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Type épargne",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(50)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Champs obligatoire';
              }
              return null;
            },
            onSaved: (String? value) => typeEpargne = value!,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButtonField() {
    return SizedBox(
      width: double.infinity,
      child: RawMaterialButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            _formKey.currentState!.save();
            //sendFormData();
          },
          elevation: 0,
          fillColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: submitButton),
    );
  }
}
