import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;  //untuk menyimpan data yang saya ketik dan kirim di app, disimpan dalam database firesotre
FirebaseUser loggedInUser;  //saya buat variabel ini nanti digunakan untuk menyimpan info data user yang sedang login (lihat method getCurrentUser untuk lebih jelasnya)

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();  //TextEditingController() merupakan class milik Flutter (bukan saya yg buat). Disimpan dalam variabel yang nantinya akan mengontrol text yang diinput di chat screen oleh pengguna. Variabel ini dipakai di TextField code dibawah
  final _auth = FirebaseAuth.instance;  //variabel instance milik FirebaseAuth merupakan variabel static. Lalu di simpan dalam _auth yang saya buat
  

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  //method ini digunakan untuk mendapatkan data usersekarang (berdasarkan ada atau tidaknya data _auth yang login)
  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser(); //disini proses mengambili data user yang sedang login
      if(user != null){ //jika ada data yang sedang login maka 
        loggedInUser = user;
        //print(loggedInUser.email); //jika ada maka, akan ngeprint email dari user yang sedang login
      }
    }catch(e){
      print(e);
    }
  }

  // method untuk mengambil data dari firebase. (Manual/bukan realtime)
  // method ini digunakan untuk uji coba saja, nantinya tidak dipakai di aplikasi
  void getMessages() async{
    // methode getDocuments() jika dihover maka terlihat, bahwa methode tersebut return ke Future<QuerySnapshot>
    // QuerySnapshot sendiri merupakan tipe data milik firebase
    // dengan dipanggilnya method ini berarti menynapshot data dari koleksi saat ini
    final messages = await _firestore.collection('messages').getDocuments();
    //messages.documents, jika kamu buka database firebasemu maka akan terlihat dokumen2mu (yang dibagian tengah, bawahnya tulisan +tambah dokumen, yang seperti tulisannya seperti token otomatis)
    //jika documents tersebut di hover maka terlihat bahwa documents tersebut merupakan suatu List, sehingga untuk mengambil tiap item yang ada di List, maka saya pakai for in loop : 
    for (var message in messages.documents) {  
      print(message.data);  //mencetak key value per item of List
    }
  }

  //[Stream] method untuk mengambil data dari firebase. (otomatis/realtime)
  //method ini digunakan untuk uji coba saja, nantinya tidak dipakai di aplikasi
  void messagesStream() async {
    // methode snapshots() milik Dart jika dihover maka terlihat, bahwa metode teersebut return ke Stream<QuerySnapshot>
    // dengan snaphost() maka setiap ada document baru di dalam koleksi messages, maka kita akan dikasih tahu (ngga harus refresh halaman jika ingin mendapatkan data tersebut). Kaya kita itu ngesubscribe koleksi messages, jadi setiap data baru pada messages akan dikasih tau ke kita
    // kita akan meloop method snapshots ini karena dasarnya method ini seperti list of Future objects
    await for( var snapshot in _firestore.collection('messages').snapshots() ){
      //jika kamu buka database firebasemu maka akan terlihat dokumen2mu (yang dibagian tengah, bawahnya tulisan +tambah dokumen, yang seperti tulisannya seperti token otomatis)
      //jika documents tersebut di hover maka terlihat bahwa documents tersebut merupakan suatu List, sehingga untuk mengambil tiap item yang ada di List, maka saya pakai for in loop : 
      for( var message in snapshot.documents){
        print(message.data);  //mencetak key value per item of List (ibarat kalo di web itu nyetak isi perbaris dari tabel *dalam hal ini table messages)
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // messagesStream(); // untuk ngetest saja stream
                _auth.signOut(); //ketika dipencet maka _authnya hancur
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(), //messageStream merupakan class yang saya buat sendiri, mereturn ke StreamBuilder
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController, //controller digunakan untuk mengontrol TextField, messageTextController merupakan variabel yang sudah saya buat di atas
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    //messageText + loggedInUser.email
                    onPressed: () {
                      // messageTextController merupakan variabel yang sudah saya buat di atas, fungsinya agar ketika user klik FlatButton (tombol send) maka text yang tadinya diketik di TextField akan hilang
                      messageTextController.clear();
                      //menyimpan data chat yang diketik ke dalam database di firebase.
                      //kalo di web artinya: tabel message, kolom text diisi dengan messageText, kolom sender diisi dengan loggeInUser.email
                      //method add ini jika dihover dia didalamnya memekai Map, jadi ada key dan valuenya
                      //jika di database belum ada collection 'message' maka collection tersebut otomatis terbuat jika kita menjalankankan kode berikut
                      _firestore.collection('messages').add({
                        'text': messageText, 
                        'sender': loggedInUser.email,
                        'dateTime': DateTime.now(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StreamBuilder adalah Widget yang build dirinya sendiri berdasarkan interaksi snapshot terbaru dengan stream
    return StreamBuilder<QuerySnapshot>(   //<QuerySnapshot> merupakan class milik Firebase, pakai ini karena jika method .snapshot(). dibawah di hover, ternyata .snapshot() return ke QuerySnapshot. Arti dari QuerySnapshot tersebut yaitu kita akan menyajikan semua data (dalam hal ini data yang ada di 'messages' collection)
      stream: _firestore.collection('messages').orderBy('dateTime').snapshots(),  //property stream digunakan untuk memberi tahu, dari mana data akan didapat
      //intinya setiap kali ada snapshot baru dari stream, maka builder akan melakukan update untuk ditampilkan di layar. Dalam hal ini builder akan mengupdate widget Column yang berisi Widget Text (*lihat return dari builder ini)
      //jika builder di hover, akan ada tulisan asyncsnapshot, asyncsnapshot ini sebenarnya berisi query snaphot dari Firebase. Jadi beda ya, asyncsnapshot milik flutter sedangkan snapshot milik firebase
      builder: (context, snapshot){ 
        if(!snapshot.hasData){  //jika snapshotnya g punya data maka kita akan melakukan spinning screen
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        
        // Maksud 1 baris kode dibawah ini: 
        // [SNAPSHOT] asnycsnapshot dari stream builder meniliki query snapshot dari Firebase
        // pake [.DATA] itu maksudnya kita mengaskses data terkini di dalam asyncsnapshot kita
        // the querysnapshot mengandung list dari [.DOCUMENTS] snapshot
        final messages = snapshot.data.documents.reversed;  //karena documentsnya berbentuk list, disini akan saya balikkan urutan list didalamnya pakai reversed
        // <MessageBubble>  merupakan class yang saya buat sendiri, didalamnya ada Text Widget
        List<MessageBubble> messageBubbles = [];
        for(var message in messages){
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          //note: snapshot.data milik flutter, sedangkan message.data milik firebase

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(  //MessageBubble merupakan class yang saya buat manual, didalamnya ada Text Widget
            sender: messageSender, 
            text: messageText,
            isMe: currentUser == messageSender, //jika sama maka isMe: true, tapi jika tidak sama maka isMe: false
          );  
          messageBubbles.add(messageBubble);
        }
        return Expanded(
            //pakai ListView tujuannya agar layarnya bisa scrollable, jadi kita bisa scrolling2 chat ke atas/bawah
            child: ListView(
              reverse: true,  //agar urutan Listnya terbalik, list terbaru jadinya di paling atas. Di snapshot.data.documents pada variabel messages di Class MessagesStream juga dikasih reversed, sehingga list terbaru jadi muncul di paling bawah
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text; 
  final bool isMe;  //variabel yang nantinya digunakan untuk mengecek apakah dia user yang sedang login atau bukan. jika iya maka isMenya true tapi jika bukan maka false. Untuk membedakan text yang sedang login dengan yang tidak login

  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender, 
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            )
          ),
          //Kita pakai Material Widget ini agar bisa dikasih property color, elevation, borderRadius, dkk.
          //kalo pake Container kita ngga bisa ngasi property borderRadius, elevation di dalamya
          Material( 
            borderRadius: isMe 
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),) 
              : BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0), 
                  topRight: Radius.circular(30.0),),
            elevation: 5.0, //memberi bayangan pada bubble
            color: isMe ? Colors.lightBlueAccent : Colors.white,  //membedakan warna bubble text yang sedang login dengan yang tidak login
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text, //variabel yang saya buat 
                style: TextStyle(
                  color: isMe? Colors.white : Colors.black54,
                  fontSize: 15.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}