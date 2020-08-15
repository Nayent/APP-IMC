import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _info = "Informe seus dados";

  void _resetFilds() {
    weightController.clear();
    heightController.clear();
    _info = "Informe seus dados";
  }

  void _calculoIMC() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 18.5) {
      _info = "Abaixo do peso { IMC = ${imc.toStringAsPrecision(4)}}";
    } else if (imc >= 18.5 && imc < 25) {
      _info = "Peso ideal { IMC = ${imc.toStringAsPrecision(4)}}";
    } else if (imc >= 25 && imc < 30) {
      _info = "Levemente acima do peso { IMC = ${imc.toStringAsPrecision(4)}}";
    } else if (imc >= 30 && imc < 34.9) {
      _info = "Obesidade grau I { IMC = ${imc.toStringAsPrecision(4)}}";
    } else if (imc >= 34.9 && imc < 40) {
      _info = "Obesidade grau II { IMC = ${imc.toStringAsPrecision(4)}}";
    } else if (imc >= 40) {
      _info = "Obesidade grau III { IMC = ${imc.toStringAsPrecision(4)}}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora do IMC"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _resetFilds();
                  });
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.blueAccent,
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira seu peso";
                      }
                    },
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    style: TextStyle(color: Colors.blueAccent),
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira sua altura";
                      }
                    },
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                    style: TextStyle(color: Colors.blueAccent),
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if(_formkey.currentState.validate()){
                            _calculoIMC();
                          }
                        });
                      },
                      color: Colors.blueAccent,
                      child: Text("Calcular",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )))),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$_info",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.blueAccent),
                ),
              )
            ]))));
  }
}
