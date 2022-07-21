import 'package:final_project_ehab/resourses/color_manager.dart';
import 'package:final_project_ehab/widgets/cast.dart';
import 'package:final_project_ehab/widgets/now_playing.dart';
import 'package:final_project_ehab/widgets/top_rated.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../widgets/trending.dart';
class Elements extends StatefulWidget {
  const Elements({Key? key}) : super(key: key);

  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  List trendingMoviesList = [];
  List topRatedMoviesList = [];
  List nowPlayingList = [];
  final apiKey = "f2dc6a51a35236c14e42a10a002823d5";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmRjNmE1MWEzNTIzNmMxNGU0MmExMGEwMDI4MjNkNSIsInN1YiI6IjYyZDAzODU1M2FmOTI5MDA0YzRmNDllOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jPMwundDgaWstlIn-YYuWWuGhD-Nxr3ka_Uss9ybqAs";
  loadMovies() async {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingMovies = await tmdb.v3.movies.getPopular();
    Map topRatedMovies = await tmdb.v3.movies.getTopRated();
    Map nowPlaying = await tmdb.v3.movies.getNowPlaying();

    setState(() {
      trendingMoviesList = trendingMovies['results'];
      topRatedMoviesList = topRatedMovies['results'];
      nowPlayingList=nowPlaying['results'];
    });
  }
  @override
  void initState() {

    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          TrendingMovies(trending: trendingMoviesList),
          TopRated(topRated: topRatedMoviesList),
          NowPlaying(nowPlaying: nowPlayingList),
          
        ],
      ),
    );
  }
}
