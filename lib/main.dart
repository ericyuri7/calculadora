import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _resultado = "0";
  String _entrada = "";
  double? _valor1;
  String? _operador;

  void _adicionarEntrada(String valor) {
    setState(() {
      _entrada += valor;
      _resultado = _entrada;
    });
  }

  void _definirOperador(String operador) {
    setState(() {
      if (_entrada.isNotEmpty) {
        _valor1 = double.tryParse(_entrada);
        _operador = operador;
        _entrada = "";
        _resultado = operador;
      }
    });
  }

  void _calcularResultado() {
    if (_valor1 != null && _operador != null && _entrada.isNotEmpty) {
      double? valor2 = double.tryParse(_entrada);
      if (valor2 != null) {
        double resultado;
        switch (_operador) {
          case '+':
            resultado = _valor1! + valor2;
            break;
          case '-':
            resultado = _valor1! - valor2;
            break;
          case '×':
            resultado = _valor1! * valor2;
            break;
          case '÷':
            resultado = _valor1! / valor2;
            break;
          default:
            resultado = 0;
        }
        setState(() {
          _resultado = resultado.toString();
          _entrada = "";
          _valor1 = null;
          _operador = null;
        });
      }
    }
  }

  void _limpar() {
    setState(() {
      _resultado = "0";
      _entrada = "";
      _valor1 = null;
      _operador = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora Flutter"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _resultado,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          _buildTeclado(),
        ],
      ),
    );
  }

  Widget _buildTeclado() {
    return Column(
      children: [
        _buildLinhaTeclado(["7", "8", "9", "÷"]),
        _buildLinhaTeclado(["4", "5", "6", "×"]),
        _buildLinhaTeclado(["1", "2", "3", "-"]),
        _buildLinhaTeclado(["C", "0", "=", "+"]),
      ],
    );
  }

  Widget _buildLinhaTeclado(List<String> teclas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: teclas.map((tecla) {
        return ElevatedButton(
          onPressed: () {
            if (tecla == "C") {
              _limpar();
            } else if (tecla == "=") {
              _calcularResultado();
            } else if (["+", "-", "×", "÷"].contains(tecla)) {
              _definirOperador(tecla);
            } else {
              _adicionarEntrada(tecla);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            shape: CircleBorder(),
            backgroundColor: Colors.blue,
          ),
          child: Text(
            tecla,
            style: TextStyle(fontSize: 24),
          ),
        );
      }).toList(),
    );
  }
}
