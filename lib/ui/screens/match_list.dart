import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../entities/football.dart';
import '../widgets/football_score_card.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key});

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];

  @override
  void initState() {
    super.initState();
    _getMatchList();
  }

  Future<void> _getMatchList() async {
    matchList.clear();
    QuerySnapshot result = await firebaseFirestore.collection('football').get();
    for (QueryDocumentSnapshot doc in result.docs) {
      Football(
        matchName: doc.id,
        firstTeamName: doc.get('Team1name'),
        secondTeamName: doc.get('Team2name'),
        firsTeamScore: doc.get('Team-1'),
        secondTeamScore: doc.get('Team-2'),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('football').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return const Center(child: Text('Empty list!'));
            }
            matchList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              Football(
                  matchName: doc.id,
                  firstTeamName: doc.get('Team1name'),
                  secondTeamName: doc.get('Team2name'),
                  firsTeamScore: doc.get('Team-1'),
                  secondTeamScore: doc.get('Team-2'));
            }

            return ListView.builder(
                itemCount: matchList.length,
                itemBuilder: (context, index) {
                  return FootballScoreCard(
                    football: matchList[index],
                  );
                });
          }),
    );
  }
}
