import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _currentInput = '';
  String _operation = '';

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operation.isNotEmpty) {
      double num1 = double.parse(_output);
      double num2 = double.parse(_currentInput);

      switch (_operation) {
        case '+':
          _output = (num1 + num2).toString();
          break;
        case '-':
          _output = (num1 - num2).toString();
          break;
        case '*':
          _output = (num1 * num2).toString();
          break;
        case '/':
          _output = (num1 / num2).toString();
          break;
      }
      _currentInput = '';
      _operation = '';
    }
  }

  void _clear() {
    _output = '';
    _currentInput = '';
    _operation = '';
  }

  void _handleOperation(String value) {
    if (_currentInput.isNotEmpty) {
      _calculateResult();
      _operation = value;
      _output = _currentInput;
      _currentInput = '';
    }
  }

  void _handleDigit(String value) {
    _currentInput += value;
    setState(() {
      _output = _currentInput;
    });
  }

  void _handleButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculateResult();
      } else if (value == 'C') {
        _clear();
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _handleOperation(value);
      } else {
        _handleDigit(value);
      }
    });
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        _handleButtonPressed(label);
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _output,
            style: const TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}
