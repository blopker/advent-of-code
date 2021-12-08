import 'dart:io';

void main(List<String> args) {
  var testData = File('4.test.txt').readAsLinesSync();
  print(get4(testData));
  print(get4p2(testData));
  var data = File('4.txt').readAsLinesSync();
  print(get4(data));
  print(get4p2(data));
}

int? get4(List<String> data) {
  var game = parseData(data);
  var winner = game.play();
  return winner?.score;
}

int? get4p2(List<String> data) {
  var game = parseData(data);
  Board? winner;
  while (game.boards.length > 0) {
    winner = game.play();
  }
  return winner?.score;
}

Game parseData(List<String> data) {
  var plays = parsePlays(data[0]);
  var boards = parseBoards(data.skip(2).toList());
  return Game(plays, boards);
}

List<int> parsePlays(String playsData) {
  return playsData.split(',').map((e) => int.parse(e)).toList();
}

List<Board> parseBoards(List<String> boardData) {
  List<Board> boards = [];
  for (var i = 0; i <= boardData.length; i += 6) {
    var b = boardData.getRange(i, i + 5);
    var c = b
        .map((e) => e
            .split(' ')
            .where((e) => e != "")
            .map((e) => int.parse(e))
            .toList())
        .toList();
    boards.add(Board(c));
  }
  return boards;
}

class Game {
  final List<int> plays;
  final List<Board> boards;
  Game(this.plays, this.boards);
  Board? play() {
    for (var p in plays) {
      for (var b in boards) {
        b.mark(p);
        if (b.isWinner()) {
          boards.remove(b);
          return b;
        }
      }
    }
    return null;
  }
}

class Board {
  final List<List<int>> numbers;
  var size = 5;
  var lastPlay = 0;
  Board(this.numbers);
  void mark(int play) {
    lastPlay = play;
    for (var row in numbers) {
      for (var i = 0; i < row.length; i++) {
        if (row[i] == play) {
          row[i] = -1;
        }
      }
    }
  }

  bool isWinner() {
    for (var i = 0; i < 5; i++) {
      var x = numbers[i].reduce((value, element) => value + element);
      var y =
          numbers.map((e) => e[i]).reduce((value, element) => value + element);
      if (x == -5 || y == -5) {
        return true;
      }
    }
    return false;
  }

  int get score {
    var score = 0;
    for (var row in numbers) {
      for (var num in row) {
        if (num != -1) {
          score += num;
        }
      }
    }
    return score * lastPlay;
  }
}
