import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String SECURE_NOTE_KEY = "KEY";

  FlutterSecureStorage storage;
  String value;

  String _sampleToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkZhdGloIiwiaWF0IjoxNTE2MjM5MDIyfQ.oUHocAHQ1NjVsuzPphjzuRpmDe0EyMLczYO7IgXFo1w";

  @override
  void initState() {
    super.initState();
    storage = FlutterSecureStorage();
  }

  @override
  void dispose() {
    super.dispose();
    storage = null;
  }

  Future _addToken() async {
    await storage.write(key: SECURE_NOTE_KEY, value: _sampleToken);
    value = "";

    Fluttertoast.showToast(
        msg: "Token başarılı bir şekilde şifrelendi ve storage' a eklendi.");
  }

  Future _readToken() async {
    value = await storage.read(key: SECURE_NOTE_KEY);

    Fluttertoast.showToast(msg: "Decrypted edilen Token: \n$value");
  }

  Future _deleteToken() async {
    if (value == null) {
      Fluttertoast.showToast(msg: "Token yok");
    } else {
      await storage.delete(key: SECURE_NOTE_KEY);
      Fluttertoast.showToast(msg: "Token başarıyla silindi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Token Storage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                "TOKEN",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Text(
                  _sampleToken,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Ekle"),
                  onPressed: () {
                    _addToken();
                  },
                ),
                SizedBox(
                  width: 32,
                ),
                ElevatedButton(
                  child: Text("Göster"),
                  onPressed: () {
                    _readToken();
                  },
                ),
                SizedBox(
                  width: 32,
                ),
                ElevatedButton(
                  child: Text("Sil"),
                  onPressed: () {
                    _deleteToken();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
