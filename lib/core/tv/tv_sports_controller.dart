import '../models/tv_sport_match.dart';

class TVSportsController {
  static List<TVSportMatch> matches = [
    const TVSportMatch(
      home: 'Arsenal',
      away: 'Chelsea',
      league: 'Premier League',
      time: '22:30',
    ),
    const TVSportMatch(
      home: 'Madrid',
      away: 'Barcelona',
      league: 'La Liga',
      time: '01:00',
    ),
  ];
}
