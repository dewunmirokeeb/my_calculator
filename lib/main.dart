import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(){
  runApp(Calculator());

}
class Calculator extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My_Calculator',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget{
  @override
  _SimpleCalculator createState() => _SimpleCalculator();
}
class _SimpleCalculator extends State<SimpleCalculator>{

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize =  48.0;


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;

      }else if(buttonText == "del"){
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length-1);
        if(equation == ""){
          equation = "0";
        }

      }else if(buttonText == "="){

        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{

          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }
      }
    });

  }

Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
  return Container(
                           height: MediaQuery.of(context).size.height *0.1 * buttonHeight,
                           color: buttonColor,
                           child: TextButton(
                             style: ButtonStyle(
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                 RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(0),
                                   side: BorderSide(
                                     color: Colors.white,
                                     width: 1,
                                     style: BorderStyle.solid,
                                     ),
                                   )
                                   )
                              ),
                              onPressed: () => buttonPressed(buttonText),
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            
                             ),
                         );
}

  @override
  Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(title: 
     Center(child: 
     Text(' Calculator '),
     ),
     ),
     body: Column(
       children: <Widget> [
         Container(
           alignment: Alignment.centerRight,
           padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
           child: Text(equation, style: TextStyle(fontSize: equationFontSize),
           ),
         ),

         Container(
           alignment: Alignment.centerRight,
           padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
           child: Text(result, style: TextStyle(fontSize: resultFontSize),
           ),
         ),

         Expanded(
           child: Divider(),
           ),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  width: MediaQuery.of(context).size.width *0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                         buildButton( "C", 1, Colors.pink ),
                         buildButton( "+", 1, Colors.green ),
                         buildButton( "-", 1, Colors.green ),
                         
                        ]
                         ),
                      TableRow(
                        children: [
                         buildButton( "1", 1, Colors.black54 ),
                         buildButton( "2", 1, Colors.black54 ),
                         buildButton( "3", 1, Colors.black54 ),
                        ]
                        ),  
                      TableRow(
                        children: [
                         buildButton( "4", 1, Colors.black54 ),
                         buildButton( "5", 1, Colors.black54 ),
                         buildButton( "6", 1, Colors.black54 ),
                        ]
                        ), 
                      TableRow(
                        children: [
                         buildButton( "7", 1, Colors.black54 ),
                         buildButton( "8", 1, Colors.black54 ),
                         buildButton( "9", 1, Colors.black54 ),
                        ]
                        ),   
                      TableRow(
                        children: [
                         buildButton( "00", 1, Colors.black54 ),
                         buildButton( "0", 1, Colors.black54 ),
                         buildButton( ".", 1, Colors.black54 ),
                        ]
                        ),   
                    ],
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton( "del", 1, Colors.green ),
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("×", 1, Colors.green)
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("÷", 1, Colors.green)
                        ]
                      ),
                      TableRow(
                        children: [
                          buildButton("=", 2, Colors.purple)
                        ]
                      )
                    ],
                  ),
                )
              ],
          ),
       ],
       ),
   );
 }
}