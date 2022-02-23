import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

final List<String> imgList = [
  "https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1134&q=80",
  "https://images.unsplash.com/photo-1598536860338-f94049735fa0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  "https://images.unsplash.com/photo-1503495451987-bb5a7b7f9422?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"
];

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.blueGrey,
        // margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Hai, User',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CarouselSlider(
                      items: imgList
                          .map(
                            (item) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber[600],
                              ),
                              child: Center(
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  // height: 150,
                                  width: 1500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        // height: 136,
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Informasi Terkini',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return new Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Container(
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(16),
                          //   topRight: Radius.circular(16),
                          // ),
                        ),
                        child: new InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const detailInfo()),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                                  height: 162,
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              new Container(
                                // color: Colors.amber,
                                width: 240,
                                // height: ,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Titelnya adalah Lorem Ipsum huhuhuhs",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "diupdate tanggal 05/02/2022",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black54),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: imgList.length,
              ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.only(top: 2),
              //       padding: EdgeInsets.all(16),
              //       decoration: BoxDecoration(
              //         // borderRadius: BorderRadius.circular(5),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.shade400,
              //             blurRadius: 2,
              //             offset: Offset(0, 2),
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         children: [
              //           Container(
              //             child: Image.network(
              //               "https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1134&q=80",
              //               fit: BoxFit.cover,
              //               height: 120,
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(left: 6),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                 Text(
              //                   "Judul yang di atas",
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //                 Text("Keterangan"),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 2),
              //       padding: EdgeInsets.all(16),
              //       decoration: BoxDecoration(
              //         // borderRadius: BorderRadius.circular(5),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.shade400,
              //             blurRadius: 2,
              //             offset: Offset(0, 2),
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         children: [
              //           Container(
              //             child: Image.network(
              //               "https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1134&q=80",
              //               fit: BoxFit.cover,
              //               height: 120,
              //             ),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(left: 6),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                 Text(
              //                   "Judul yang di atas",
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //                 Text("Keterangan"),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class detailInfo extends StatefulWidget {
  const detailInfo({Key? key}) : super(key: key);

  @override
  detailInfoState createState() => detailInfoState();
}

class detailInfoState extends State<detailInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi Detail"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                      "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                  // borderRadius: BorderRadius.circular(16),
                ),

                //--Title Artikel--
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Titelnya adalah Lorem Ipsum",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget velit et tellus lobortis vehicula. Vestibulum ullamcorper maximus gravida. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sit amet orci pulvinar, laoreet est nec, feugiat enim. Suspendisse ut nunc odio. Pellentesque porttitor turpis id massa ultricies varius. Sed vestibulum, ligula sed sollicitudin interdum, risus libero eleifend nisl, eget ornare enim justo eu risus. Proin vulputate neque a mauris laoreet, consectetur cursus ipsum suscipit. Vivamus imperdiet, tortor at laoreet porta, neque dui iaculis purus, non dapibus sapien libero non urna. Cras accumsan, nulla eu convallis laoreet, massa ipsum rutrum massa, eget euismod nibh augue scelerisque mi. Aliquam ullamcorper lacus in tellus fringilla suscipit. Mauris et scelerisque turpis, non varius elit. Fusce vulputate condimentum dictum. Mauris in metus condimentum, venenatis mi et, euismod dolor. Aliquam in massa massa. \n Quisque faucibus sapien ornare fringilla placerat. Aenean posuere et risus in gravida. Vestibulum a ullamcorper felis. Duis odio ipsum, dictum vitae fringilla eu, maximus a urna. Praesent ac malesuada eros, vitae molestie turpis. Integer vitae orci viverra, bibendum justo ac, cursus mi. Cras accumsan purus ipsum, sed suscipit est iaculis ut. Quisque vehicula tortor ex, id lobortis ipsum mollis ut. Sed eu urna vitae nunc hendrerit eleifend euismod a lacus. Morbi finibus enim non quam ultrices accumsan. Sed eu aliquet urna, posuere vulputate leo. Curabitur in suscipit mi, eu mollis arcu. \n Donec ac commodo neque. Aliquam nisi enim, hendrerit eget leo sit amet, facilisis rutrum nulla. Morbi rhoncus, ex et rhoncus varius, nunc libero luctus nisi, id efficitur elit elit nec lectus. Aenean ac eros ut nunc hendrerit fermentum id in ex. Aliquam porttitor porta accumsan. Sed porta massa sed libero laoreet aliquet. Sed scelerisque lobortis vestibulum. Donec congue urna ullamcorper euismod euismod. Vivamus interdum consequat eros, ac scelerisque dolor lobortis sed. Maecenas nec arcu ipsum. Maecenas ac venenatis neque, id tempus massa. Ut aliquet odio ac fringilla euismod. ",
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.5,
                          wordSpacing: 2,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                //Isi artikel
                // Container(
                //   // margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                //   margin: EdgeInsets.only(
                //     top: 0,
                //     bottom: 16,
                //     left: 16,
                //     right: 16,
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "nabfdaoifiaobfoiabfoiabfabfaifoiafanianvi ainvianv",
                //         style: TextStyle(
                //           fontSize: 12,
                //           letterSpacing: 0.5,
                //           height: 1.5,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
