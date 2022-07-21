import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Description extends StatefulWidget {
  final String  description, bannerurl, posterurl, vote, launch_on;
  final String name;

  final int id;
  final int castId;
  const Description(
      {Key? key,
      required this.id,
       required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on,
      required this.castId})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

bool clicked = true;

class _DescriptionState extends State<Description> {
  List cast = [];

  final apiKey = "f2dc6a51a35236c14e42a10a002823d5";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmRjNmE1MWEzNTIzNmMxNGU0MmExMGEwMDI4MjNkNSIsInN1YiI6IjYyZDAzODU1M2FmOTI5MDA0YzRmNDllOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jPMwundDgaWstlIn-YYuWWuGhD-Nxr3ka_Uss9ybqAs";
  loadMovies() async {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map tPC = await tmdb.v3.movies.getCredits(widget.castId);

    setState(() {
      cast = tPC['cast'];
    });
  }

  @override
  void initState() {

    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var heartIcon = const Icon(Icons.favorite_border);
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.vertical,
            children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: Text(
                      '⭐ Rate: ' + widget.vote,
                      style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s16),
                    )),
              ])),
          const SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child:

              Text(

                widget.name.toString(),
                style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s20),
              )),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Releasing On - ' + widget.launch_on,
                style: getBoldStyle(color: ColorManager.white),
              )),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.description,
                      style: getRegularStyle(color: ColorManager.white),
                    )),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 130.0,
              padding: const EdgeInsets.only(left: 10.0),
              child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (context, index) {
                    if (cast[index]['profile_path']==null) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
                          child: GestureDetector(
                              onTap: () {},
                              child:
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50.0)),
                                      child: SizedBox(
                                        height: 80.0,
                                        child: AspectRatio(
                                            aspectRatio: 2 / 3,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  2.8,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                image: DecorationImage(
                                                  image:AssetImage('assets/images/unknown.png')
                                                   ),
                                                color: Colors.black12,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Text(cast[index]['name']??"No name Available",softWrap: true,style: getSemiBoldStyle(color: ColorManager.white,fontSize: 10),)
                                  ])));

                    }  else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
                        child: GestureDetector(
                            onTap: () {},
                            child:
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50.0)),
                                    child: SizedBox(
                                      height: 80.0,
                                      child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height /
                                                2.8,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              image: DecorationImage(

                                                  image: NetworkImage(

                                                      'https://image.tmdb.org/t/p/w500'+cast[index]['profile_path']
                                                  )),
                                              color: Colors.black12,
                                            ),
                                          )),
                                    ),
                                  ),
                                  Text(cast[index]['name']??"No name Available",softWrap: true,style: getSemiBoldStyle(color: ColorManager.white,fontSize: 8),)
                                ])));
                    }
                  }

              )),
          IconButton(
            onPressed: () {
              setState(() {
                uploadFavorite();
                clicked = !clicked;
                Fluttertoast.showToast(
                  msg: "Add to Favorites!",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              });
            },
            icon: Icon(
              (clicked == false) ? Icons.favorite_border : Icons.favorite,
              size: 50,
              color: ColorManager.white,
            ),
          ),
        ]),
      ),
    );
  }
  Future uploadFavorite() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-favourite-movies");
      return _collectionRef.doc(user!.email).collection("favorites").doc().set({
        "name": widget.name,
        "image": widget.posterurl,
      }).then((value) => print("Added to favourite"));
    } catch (e) {
      print(e);
    }
  }
}
