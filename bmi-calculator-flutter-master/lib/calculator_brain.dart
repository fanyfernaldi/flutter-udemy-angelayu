import 'dart:math';

class CalculatorBrain{
  CalculatorBrain({this.height, this.weight});

  final height;
  final weight;

  double _bmi;

  //rumus menghitung BMI berat(kg) / tinggi(m)^2
  String calculateBMI(){
    _bmi = weight / pow(height/100, 2);   //karena height yang ada di input_page.dart (m), maka diganti jadi (cm) dulu sebelum di kuadratkan
    return _bmi.toStringAsFixed(1); //toStringAsFixed(1) artinya nanti hasilnya akan ada 1 angka dibelakang koma
  }
  
  //menampilkan kesimpulan (overweight/normal/underweight), berdasarkan hasil dari rumus
  String getResult(){
    if(_bmi > 25){
      return 'Overweight';
    }else if(_bmi > 18.5){
      return 'Normal';
    }else{
      return 'Underweight';
    }
  }

  //menampilkan penafsiran dari hasil kalkulator bmi
  String getInterpretation(){
    if(_bmi > 25){
      return 'You have a higher than normal body weight. Try to exercise more.';
    }else if(_bmi > 18.5){
      return 'You have a normal body weight. Good job!';
    }else{
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }

}