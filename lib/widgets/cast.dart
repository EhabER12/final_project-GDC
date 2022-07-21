import 'package:final_project_ehab/pages/description/description.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/strings_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cast extends StatelessWidget {
  
  //https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=<<api_key>>&language=en-US
  final List cast;
  const Cast({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.trending,
            style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 270,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cast.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius:const BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                cast[index]
                                                ['profile_path']))),
                              ),
                              Text(
                                cast[index]['name'] ?? "No Name Avalibale",
                                style: GoogleFonts.aladin(color: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}