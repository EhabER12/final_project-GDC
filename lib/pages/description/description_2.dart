

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'description_2.dart';

class NewStyle extends StatefulWidget {
  final String  description, bannerurl, posterurl, vote, launch_on;
  final String name;

  final int id;
  final int castId;
  const NewStyle(
      {Key? key,
        required this.id,
        required this.name,
        required this.bannerurl,
        required this.posterurl,
        required this.vote,
        required this.launch_on,
        required this.castId, required this.description})
      : super(key: key);

  @override
  State<NewStyle> createState() => _NewStyleState();
}

bool clicked = true;

class _NewStyleState extends State<NewStyle> {
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
      body: Stack(
        children: [
          Opacity(opacity: 0.4,
          child: Image(height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.bannerurl,
            ),
            
          ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                    ],
                  ),
                  ),
                  SizedBox(height: 40,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.error.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 10,
                            )
                          ]
                          ),
                          child: ClipRRect(borderRadius: BorderRadius.circular(20),
                            child: Image(height: 250,width: 180,image: NetworkImage(
                                widget.posterurl
                            ),),

                          ),
                        ),

                      ],
                    ) ,),
                  Text(widget.name,style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s18),),
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child:
                    Text("OverView: ",style: getBoldStyle(color: ColorManager.error,fontSize: FontSize.s18),)
                    ,)
                  ,Padding(padding: EdgeInsets.all(20),
                  child:
                  Text(" "+widget.description,style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s16),)
                    ,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Cast: " ,style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s14),),

                 ),
                  Container(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          ),
                      itemCount: cast.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                ),
                                elevation: 3,
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    'https://image.tmdb.org/t/p/w200${cast[index]['profile_path']}',
                                    imageBuilder:
                                        (context, imageBuilder) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          image: DecorationImage(
                                            image: imageBuilder,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) =>
                                        Container(
                                          width: 80,
                                          height: 80,
                                          child: Center(

                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/unknown.png'),
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    cast[index]['name']??"No Name Avaliable".toUpperCase(),
                                    style: getSemiBoldStyle(color: ColorManager.white,fontSize: 8)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),


                  
                  
                  
                ],
              ),

            ),
          ),
          


        ],
      )
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
