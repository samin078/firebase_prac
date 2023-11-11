import 'package:flutter/material.dart';
import 'story_brain.dart';



void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  onPressed: () {
                    //Choice 1 made by user.
                    setState(() {
                      if(storyBrain.storyNumber==0) {
                        storyBrain.nextStory(1);
                        storyBrain.storyNumber = 2;
                      }
                      else if(storyBrain.storyNumber==1) {
                        storyBrain.nextStory(1);
                        storyBrain.storyNumber = 2;
                      }
                      else if(storyBrain.storyNumber==2) {
                        storyBrain.nextStory(1);
                        storyBrain.storyNumber = 5;
                      }
                      else {
                        storyBrain.storyNumber = 0;
                      }
                    });
                  },
                  color: Colors.red,
                  child: Text(
                    storyBrain.getChoice1(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: MaterialButton(
                    onPressed: () {
                      //Choice 2 made by user.
                      setState(() {
                        if(storyBrain.storyNumber==0) {
                          storyBrain.nextStory(2);
                          storyBrain.storyNumber = 1;
                        }
                        else if(storyBrain.storyNumber==1) {
                          storyBrain.nextStory(2);
                          storyBrain.storyNumber = 3;
                        }
                        else if(storyBrain.storyNumber==2) {
                          storyBrain.nextStory(2);
                          storyBrain.storyNumber = 4;
                        }
                        else {
                          storyBrain.storyNumber = 0;
                        }
                      });

                    },
                    color: Colors.blue,
                    child: Text(
                      storyBrain.getChoice2(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
