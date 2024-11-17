import 'package:flutter/material.dart';
import 'package:sports_live_score/ui/screens/match_list.dart';

class SportsApp extends StatelessWidget {
  const SportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MatchList(),
    );
  }
}
