import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  String _textoSalvo = "Nada Salvo!";

  _salvar() async {
    String valorDigitado = _controller.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);
    print("Operação (Salvar): $valorDigitado");
  }

  _recuperar() async {
    final prefs = await SharedPreferences.getInstance();
        setState(() {
      _textoSalvo =  prefs.getString("nome") ?? "Nada Salvo!";
    });
    print("Operação (Recuperar): $_textoSalvo");
  }

  _remover() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
    print("Operação (Remover): $_textoSalvo");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Recuperar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Text(
                _textoSalvo,
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "digite algo",
                ),
                controller: _controller,
              ),
              SizedBox(height: 20), // Espaçamento vertical de 20 pixels
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: _salvar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "salvar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: _recuperar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Recuperar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: _remover,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        textStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Remover",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
