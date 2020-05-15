import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/bottom_button.dart';


class ResultsPage extends StatelessWidget {
  ResultsPage({@required this.interpretation, @required this.bmiResult, @required this.resultText});

  //property2 ini akan didefinisikan di input_page.dart, dan akan diisi nilai oleh method milik objek dengan class CalculatorBrain
  final String bmiResult;       //menampilkan tulisan overweight/normal/underwater  
  final String resultText;      //menampilkan angka
  final String interpretation;  //menampilkan penafsiran

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //spaceEvenly disini untuk memberikan space yang merata antar children (before, between, after) di kolom ini
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,  //agar tulisannya ke bawah kanan
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    resultText.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    interpretation,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              )
            ),
          ),
          BottomButton(
            onTap: (){
              Navigator.pop(context);
            }, 
            buttonTitle: 'RE-CALCULATE'
          )
        ],
      )
    );
  }
}