import 'package:final_project_ehab/pages/description/description.dart';
import 'package:final_project_ehab/pages/description/description_2.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/strings_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.trending,
            style:
                getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22),
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
                    itemCount: trending.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Description(
                                      vote: trending[index]['vote_average']
                                          .toString(),
                                      backgroundImage:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['backdrop_path'],
                                      name: trending[index]['title'],
                                      description: trending[index]['overview'],
                                      posterImage:
                                          'https://image.tmdb.org/t/p/w500' +
                                              trending[index]['poster_path'],
                                      releaseDate: trending[index]
                                          ['release_date'],
                                      id: trending[index]['id'],
                                      castId: trending[index]['id'])));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trending[index]
                                                    ['poster_path']))),
                              ),
                              Text(
                                trending[index]['title'] ?? "No Name Avalibale",
                                style: GoogleFonts.aladin(
                                    color: ColorManager.white),
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
