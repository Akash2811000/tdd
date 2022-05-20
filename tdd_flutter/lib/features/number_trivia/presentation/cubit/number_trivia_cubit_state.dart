abstract class InitailState{}

class userState extends InitailState{}

class userStateLoding extends InitailState{}

class userStateEnd extends InitailState{}

class userStateSucc extends InitailState{
  String number;
  userStateSucc(this.number);
}

class userStateFail extends InitailState{
  String message;
  userStateFail(this.message);
}
