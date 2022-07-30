import 'package:final_project_ehab/pages/description/description.dart';
import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/resourses/fonts_manager.dart';
import 'package:final_project_ehab/resourses/strings_manager.dart';
import 'package:final_project_ehab/resourses/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRated extends StatelessWidget {
  final List topRated;

  const TopRated({Key? key, required this.topRated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int castId;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.topRated,
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
                    itemCount: topRated.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          castId = topRated[index]['id'];
                          print(castId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Description(
                                        vote: topRated[index]['vote_average']
                                            .toString(),
                                        backgroundImage:
                                            'https://image.tmdb.org/t/p/w500' +
                                                topRated[index]
                                                    ['backdrop_path'],
                                        name: topRated[index]['title'],
                                        description: topRated[index]
                                            ['overview'],
                                        posterImage:
                                            'https://image.tmdb.org/t/p/w500' +
                                                topRated[index]['poster_path'],
                                        releaseDate: topRated[index]
                                            ['release_date'],
                                        id: topRated[index]['id'],
                                        castId: topRated[index]['id'],
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
                                                topRated[index]
                                                    ['poster_path']))),
                              ),
                              Text(
                                topRated[index]['title'],
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
