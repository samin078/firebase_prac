class Story{
  String storyTitle="";
  String choice1="";
  String choice2="";



 Story({required String storyTitle, required String choice1, required String choice2}) {
     this.storyTitle=storyTitle;
     this.choice1=choice1;
     this.choice2=choice2;
   }


}

Story newStory = Story(storyTitle: "", choice1: "", choice2: "");
