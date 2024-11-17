import 'package:flutter/material.dart';
import 'package:sports_live_score/entities/football.dart';

class FootballScoreCard extends StatelessWidget {
  const FootballScoreCard({
    super.key,
    required this.football,
  });

  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            teamDetails(football.firstTeamName, football.firsTeamScore),
            const Text('vs'),
            teamDetails(football.secondTeamName, football.secondTeamScore),
          ],
        ),
      ),
    );
  }

  Column teamDetails(String teamName, int score) {
    return Column(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
