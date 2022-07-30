import 'package:final_project_ehab/pages/description/description.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/strings_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends StatelessWidget {
  final List nowPlaying;
  const NowPlaying({Key? key, required this.nowPlaying}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.nowPlaying,
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
                    itemCount: nowPlaying.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Description(
                                        vote: nowPlaying[index]['vote_average']
                                            .toString(),
                                        backgroundImage:
                                            'https://image.tmdb.org/t/p/w500' +
                                                nowPlaying[index]
                                                    ['backdrop_path'],
                                        name: nowPlaying[index]['title'],
                                        description: nowPlaying[index]
                                            ['overview'],
                                        posterImage:
                                            'https://image.tmdb.org/t/p/w500' +
                                                nowPlaying[index]
                                                    ['poster_path'],
                                        releaseDate: nowPlaying[index]
                                            ['release_date'],
                                        id: nowPlaying[index]['id'],
                                        castId: nowPlaying[index]['id'],
                                      )));
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
                                                nowPlaying[index]
                                                    ['poster_path']))),
                              ),
                              Text(
                                nowPlaying[index]['title'] ??
                                    "No Name Avalibale",
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
