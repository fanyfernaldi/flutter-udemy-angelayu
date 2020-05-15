import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  //didapat dari flutter package di websitenya flutter
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_boutton.dart';
import 'package:bmi_calculator/calculator_brain.dart';

//membuat konstanta, kenapa pakai konstanta bukan final? Karena konstanta hanya dapat dideklarasikan ketika program tidak sedang berjalan sebelumnya (Inilah fungsi konstanta). Sedangkan final, walaupun program sudah berjalan, namun kita bisa mendeklarasikan final. Konstanta berikut ini telah diterapkan di beberapa line kode, sehingga jika kita ingin merubahnya kita bisa merubah lewat konstanta saja, tidak merubah kode satu persatu
//sekarang semua sudah dipindah di constants.dart

//membuat enum Gender, untuk male dan female. Note: membuat enum harus dilakukan di luar class, enum juga harus diawali dengan hurus besar (seperti membuat class)
enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  // Color maleCardColour = kInactiveCardColour;
  // Color femaleCardColour = kInactiveCardColour;

  //TIDAK DIGUNAKAN LAGI KARENA TERLALU PANJANG, UNTUK MEMPERSINGKAT, SAYA MENGGUNAKAN TERNARY OPERATOR
  //1 = male, 2 = female <- tidak digunakan karena kita sudah memakai enum Gender
  // void updateColour(Gender selectedGender){ //Gender, merupakan enum yang sudah kita buat di atas
  //   //male card pressed
  //   if (selectedGender == Gender.male){
  //     if(maleCardColour == inactiveCardColour){
  //       maleCardColour = activeCardColour;
  //       femaleCardColour = inactiveCardColour;
  //     }else{
  //       maleCardColour = inactiveCardColour;
  //     }
  //   }
  //   //female card pressed
  //   if(selectedGender == Gender.female){
  //     if(femaleCardColour == inactiveCardColour){
  //       femaleCardColour = activeCardColour;
  //       maleCardColour = inactiveCardColour;
  //     }else{
  //       femaleCardColour = inactiveCardColour;
  //     }
  //   }
  // }

  Gender selectedGender;
  int height  = 180;
  int weight  = 60;
  int age     = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  //refaktoring kode, karena ada beberapa line code yang sama, maka code tersebut di refaktor agar kodingan kita menjadi lebih rapi dan bersih. ReusableCard() merupakan refaktor dari class GestureDetector. Untuk membuat refaktor caranya klik class yang mau di refaktor (dalam hal ini GestureDetector), lalu beri nama refaktornya (saya memberi nama 'ReusableCard', karena akan digunakan berulang2). Kalau sudah, secara otomatis (dibawah kodingan) akan terbuat class ReusableCard yang didalamnya mereturn ke class GestureDetector.
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;  //penerapan enum Gender
                      });
                    },
                    //colour merupakan custom properti dari ReusableCard yang kita buat
                    //activateCardColour merupakan suatu konstanta yang sudah kita buat di atas
                    colour: selectedGender == Gender.male? kActiveCardColour : kInactiveCardColour, //menggunakan ternary operator
                    //cardChild merupakan custorm properti yang kita buat di ReusableCard
                    //IconContent merupakan refaktoring kode dari Coloumn, lihat Widget IconContent yang saya buat di bawah class ini
                    cardChild: IconContent(icon: FontAwesomeIcons.mars, label: 'MALE'),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour, //menggunakan ternary operator
                    cardChild: IconContent(icon: FontAwesomeIcons.venus, label: 'FEMALE'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //agar 180 dan cm tulisannya sejajar maka harus menggunakan baseline
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    //ketika menggunakan baseline, maka kita harus me-set textBaselinenya 
                    textBaseline: TextBaseline.alphabetic,
                    children:<Widget>[
                      Text(
                        height.toString(),  //karena text harus string maka di konversikan ke to string dulu
                        style: kNumberTextStyle
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle
                      )
                    ]
                  ),
                  SliderTheme(  //slidertheme ini merupakan bawaan flutter. Di flutter banyak widget memiliki Theme, sehingga kita bisa menerapkan theme tersebut (cari saja di docsnya flutter banyak kok tema2 widget)
                    data: SliderTheme.of(context).copyWith(   //.of ini merupakan method bawaan, hover saja jika ingin melihat keternagannya. lalu context di dalam .of itu merujuk ke context terdekat, yaitu yang ada di BuildContext context di atas. Sedangkan copyWith merupakan tema apa yang akan di digunakan
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0XFF8D8E98),
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      //tidak digunakan lagi karena digunakannya di SliderTheme diatas, karena kalo disini akan mengoverride yang di sliderTheme
                      // activeColor: Colors.white,  //slide yang aktif (sebelah kiri)
                      // inactiveColor: Color(0xFF8D8E98),  //slide yang tidak aktif (sebelah kanan)

                      onChanged: (double newValue){  //onChanged milik Slider memang ada parameternya, jadi jangan bingung, coba kamu hover ke tulisan onChanged
                        setState(() {
                          height = newValue.round();  //tujuan dikasih round agar membulatkan newValue, karena height tipenya int 
                        });
                      },
                    ),
                  )
                ],
              ),
              colour: kActiveCardColour,
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(  //RoundIconButton merupakan Widget yang saya buat sendiri, lihat di bawah sendiri
                              icon: FontAwesomeIcons.minus, 
                              onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              }
                            ),
                            SizedBox(
                              width: 10.0
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus, 
                              onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              }
                            )
                          ],
                        )
                      ],
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus, 
                              onPressed: (){
                                setState(() {
                                  age--;
                                });
                              }
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              }
                            )
                          ],
                        )
                      ]
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            onTap: (){
              //membuat objek dari Class Calcultator Brain, sebagai otak dari bmi calculator
              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    //mempassing method2 milik CalculatorBrain yang telah di masukkan ke property yang sebelumnya property tersebut sudah dideklarasikan di results.page.dart, agar bisa digunakan di results_page
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  )
                )
              );
            },
            buttonTitle: 'CALCULATE',
          )
        ],
      )
    );
  }
}

//class ReusableCard 
//dan
//class IconContent dan class2 lain sudah saya pisahkan di file yang berbeda agar lebih rapi


