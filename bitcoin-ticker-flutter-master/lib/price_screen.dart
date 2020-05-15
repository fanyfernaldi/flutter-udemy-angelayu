import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;   //pada dart:io, saya hanya mengambil class Platform saja. Nantinya akan digunakan untuk mengecek apakah devicenya IoS atau Android

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //Update the default currency to AUD, the first item in the currenyList.
  String selectedCurrency = 'AUD';

  //membuat fungsi dropdown button untuk currencies 
  // [1] PAKAI VERSINYA ANDROID, hasilnya kaya select option yang ada di web
  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>> dropdownItems = [];  //namanya bebas ngga harus dropdownItems. Ini dibuat untuk menyimpan list of DropdownMenuItem
    
    //LOOPING CARA1 menggunakan C style loops
    // for(int i=0; i<currenciesList.length; i++){
    //   String currency = currenciesList[i];
    
    //LOOPING CARA2 menggunakan for in (lebih simpel)
    for(String currency in currenciesList){

      var newItem = DropdownMenuItem( //dropDownMenuItem itu widget milik material.dart ya.. artinya bukan saya yg buat
        child: Text(currency), 
        value: currency
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(  //DropdownButton pasti memiliki property item dan onChanged
      value: selectedCurrency,  //nilai awal yang munul di tombol dropdown. selectedCurrency merupakan variabel yang sudah saya buat di atas
      //KASUS1 CARA MANUAL
      // items: [                  //item itu yang nantinnya menu2 yang akan ditampilkan dilayar
      //   DropdownMenuItem(
      //     child: Text('USD'),  
      //     value: 'USD',        
      //   ),
      //   DropdownMenuItem(
      //     child: Text('EUR'),
      //     value: 'EUR',
      //   ),
      //   DropdownMenuItem(
      //     child: Text('GBP'),
      //     value: 'GBP'
      //   ),
      // ],
      //KASUS2, menggunakan looping yang sudah saya buat di atas
      items: dropdownItems, 
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
          // Call getData() when the picker/dropdown changes
          getData();
        });
      },
    );
  }

  // [2] PAKAI VERSINYA IOS menggunakan cuppertino picker (biar nyekroll, ngga selectbutton kaya yang di android)
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for(String currency in currenciesList){
      var newItem = Text(currency, style: TextStyle(color: Colors.white),);
      pickerItems.add(newItem);
      //kalau mau langsung juga boleh
      // picerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0, 
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          // save the selected currency to the property selectedCurrency
          selectedCurrency = currenciesList[selectedIndex];
          // Call getData() when the picker/dropdown changes.
          getData();
        });
      }, 
      //KASUS 1, cara manual
      // children: [
      //   Text('USD'),
      //   Text('EUR'),
      //   Text('GBP'),
      // ]
      
      //KASUS 2, menggunakan looping yang sudah saya buat fungsinya di atas
      children: pickerItems,
    );
  }

  //value had to be updated into a Map to store the value of all three cryptocurrencies.
  Map<String, String> coinValues = {};
  //7: Figure out a way of displating a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  // Create an async method here await the coin data from coin_data.dart
  void getData() async {
    //: Second, we set it to true when initiate the request for prices.
    isWaiting = true;
    try {
      //6: Update this method to receive a Map containing the crypto:price key value pairs
      var data = await CoinData().getCoinData(selectedCurrency);
      // We can't await in a setState(). So you have to separate it out into two steps.
      //7: Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  //
  @override
  void initState() {
    super.initState();
    // Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  ////For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each. Call makeCards() in the build() method instead of the Column with 3 CryptoCards.
//  Column makeCards() {
//    List<CryptoCard> cryptoCards = [];
//    for (String crypto in cryptoList) {
//      cryptoCards.add(
//        CryptoCard(
//          cryptoCurrency: crypto,
//          selectedCurrency: selectedCurrency,
//          value: isWaiting ? '?' : coinValues[crypto],
//        ),
//      );
//    }
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: cryptoCards,
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //3: You'll need to use a Column Widget to contain the tree CryptoCards
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                cryptoCurrency: 'BTC', 
                //7: Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
                value: isWaiting ? '?' : coinValues['BTC'], 
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH', 
                value: isWaiting ? '?' : coinValues['ETH'], 
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC', 
                value: isWaiting ? '?' : coinValues['LTC'], 
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //mengecek apakah device kita menggunakan IoS atau Android, 
            //method iOSPicker() dan andoidDropdown() sudah saya buat di atas,
            //Platform.isIOS merupakan bawaan dari class Platform yang saya import di atas
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

//1: Refactor this Padding Widget into a separate Stateless Widget called CryptoCard, so we can create 3 of them, one for each cryptocurrency.
class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //15 Update the Text Widget with the data in cryptoCurrencyInUSD.
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
