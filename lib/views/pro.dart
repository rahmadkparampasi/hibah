import 'package:flutter/material.dart';

class pro extends StatefulWidget {
  const pro({Key? key}) : super(key: key);

  @override
  _proState createState() => _proState();
}

class _proState extends State<pro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Column(
              children: [
                Container(
                  child: Text(
                    'PROPOSAL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //Nama Lengkap
            TextFormField(
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Nama Lengkap Terlebih Dahulu";
                }
              },
              cursorColor: Colors.indigoAccent[700],
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Masukan Nama Lengkap Anda",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            //Jenis Kelamin New
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                labelText: "Jenis Kelamin",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Pilih Jenis Kelamin",
              ),
              items: [
                new DropdownMenuItem(
                  child: Text('Laki-Laki'),
                  value: 'L',
                ),
                new DropdownMenuItem(
                  child: Text('Perempuan'),
                  value: 'P',
                ),
              ],
              onChanged: (value) {
                print(value);
                setState(() {});
              },
            ),
            SizedBox(
              height: 15,
            ),

            //Tempat Lahir
            TextFormField(
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Tempat Lahir Terlebih Dahulu";
                }
              },
              cursorColor: Colors.indigoAccent[700],
              decoration: InputDecoration(
                labelText: "Tempat Lahir",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Masukan Tempat Lahir Anda",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 15,
            ),

            //Identitas
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                labelText: "Jenis Identitas",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Pilih Jenis Identitas",
              ),
              items: [
                new DropdownMenuItem(
                  child: Text('KTP'),
                  value: 'BXh01',
                ),
                new DropdownMenuItem(
                  child: Text('SIM'),
                  value: 'FXW01',
                ),
                new DropdownMenuItem(
                  child: Text('KTP WNA'),
                  value: 'N8F01',
                ),
                new DropdownMenuItem(
                  child: Text('KITAP'),
                  value: 'Npr01',
                ),
                new DropdownMenuItem(
                  child: Text('KITAS'),
                  value: 'Tzy01',
                ),
                new DropdownMenuItem(
                  child: Text('KARTU BPJS'),
                  value: 'Wk401',
                ),
                new DropdownMenuItem(
                  child: Text('PASPOR'),
                  value: 'XfV01',
                ),
              ],
              onChanged: (value) {
                print(value);
                setState(() {});
              },
            ),
            SizedBox(
              height: 15,
            ),

            //No. Identits
            TextFormField(
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan No. Identitas Terlebih Dahulu";
                }
              },
              cursorColor: Colors.indigoAccent[700],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                labelText: "No. Identitas Dan Username",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Masukan No. Identitas Anda",
              ),
            ),
            SizedBox(
              height: 15,
            ),

            //Password
            TextFormField(
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Password Terlebih Dahulu";
                }
              },
              cursorColor: Colors.indigoAccent[700],
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "Masukan Password Anda",
              ),
            ),
            SizedBox(
              height: 20,
            ),

            MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              color: Colors.indigoAccent[700],
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Apakah Anda Ingin Menyimpan Data Ini ?"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    color: Colors.indigoAccent,
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    color: Colors.indigoAccent,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Batal",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                'Ajukan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
