import 'dart:io';
import './lib.dart';

var day = '11';
var flashes = 0;
var stepN = 0;
void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, 100));
  print(1656);
  print(run2(testData));
  print(195);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data, 100));
  print(run2(data));
}

int run(List<String> data, int steps) {
  flashes = 0;
  var grid =
      data.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();
  stepN = 0;
  for (var i = 0; i < steps; i++) {
    step(grid);
  }
  return flashes;
}

int run2(List<String> data) {
  flashes = 0;
  var grid =
      data.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();
  stepN = 0;
  for (var i = 0; i < 9999; i++) {
    var synced = step(grid);
    if (synced) {
      return i + 1;
    }
  }
  return 0;
}

bool step(List<List<int>> grid) {
  for (var l in grid) {
    for (var i = 0; i < l.length; i++) {
      l[i]++;
    }
  }
  flash(grid);
  var synced = true;
  for (var l in grid) {
    for (var i = 0; i < l.length; i++) {
      if (grid[0][0] != l[i]) {
        synced = false;
      }
    }
  }
  // for (var item in grid) {
  //   print(item);
  // }
  // print('------------');
  return synced;
}

void flash(List<List<int>> grid) {
  var oldFlash = flashes;
  var shouldFlash = false;
  for (var g = 0; g < grid.length; g++) {
    for (var i = 0; i < grid[g].length; i++) {
      if (grid[g][i] > 9) {
        shouldFlash = true;
      }
    }
  }
  if (!shouldFlash) {
    return;
  }
  for (var g = 0; g < grid.length; g++) {
    for (var i = 0; i < grid[g].length; i++) {
      if (grid[g][i] <= 9) {
        continue;
      }
      grid[g][i] = 0;
      flashes++;
      if (g < grid.length - 1) {
        if (grid[g + 1][i] != 0) {
          grid[g + 1][i]++;
        }
      }
      if (g > 0) {
        if (grid[g - 1][i] != 0) {
          grid[g - 1][i]++;
        }
      }
      if (i > 0) {
        if (grid[g][i - 1] != 0) {
          grid[g][i - 1]++;
        }
      }
      if (i < grid[0].length - 1) {
        if (grid[g][i + 1] != 0) {
          grid[g][i + 1]++;
        }
      }

      if (g < grid.length - 1 && i < grid[0].length - 1) {
        if (grid[g + 1][i + 1] != 0) {
          grid[g + 1][i + 1]++;
        }
      }
      if (g > 0 && i > 0) {
        if (grid[g - 1][i - 1] != 0) {
          grid[g - 1][i - 1]++;
        }
      }
      if (i > 0 && g < grid.length - 1) {
        if (grid[g + 1][i - 1] != 0) {
          grid[g + 1][i - 1]++;
        }
      }
      if (g > 0 && i < grid[0].length - 1) {
        if (grid[g - 1][i + 1] != 0) {
          grid[g - 1][i + 1]++;
        }
      }
    }
  }
  flash(grid);
}
