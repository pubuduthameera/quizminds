import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmind/views/creat_quiz.dart';
import 'package:quizmind/views/play_quiz.dart';
import 'package:quizmind/widgets/widget.dart';

class Home extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    Future getQuiz() async {
      var firestore = Firestore.instance;
      //TODO
      // change the collection name to your one
      QuerySnapshot quiz = await firestore.collection('Quiz').getDocuments();
      return quiz.documents;
    }

    return Scaffold(
      appBar: AppBar(
        title:appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
      body: FutureBuilder(
        future: getQuiz(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Container();
          } else {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())

                :ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Text('HomePage is working, problem is in quiztile text');
              },
            );
          }
        },
      ),
    );
  }
}

class QuizTitle extends StatelessWidget {

  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;
  QuizTitle({@required this.imgUrl,@required this.title,@required this
      .desc,@required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayQuiz(
                quizid
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600) ,),
                  SizedBox(height: 6,),
                  Text(desc, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500) ,),
                ],),
            )
          ],
        ),
      ),
    );
  }
}