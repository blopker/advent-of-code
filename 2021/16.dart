import 'dart:io';
import 'dart:math';

var day = '16';

var cmap = {
  '0': '0000',
  '1': '0001',
  '2': '0010',
  '3': '0011',
  '4': '0100',
  '5': '0101',
  '6': '0110',
  '7': '0111',
  '8': '1000',
  '9': '1001',
  'A': '1010',
  'B': '1011',
  'C': '1100',
  'D': '1101',
  'E': '1110',
  'F': '1111',
};

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData));
  var data = File('$day.txt').readAsLinesSync();
  print(run(data));
}

Packet run(List<String> data) {
  Packet? p = null;
  for (var hex in data) {
    var bin = toBin(hex);
    print(hex);
    p = makePacket(bin);
    print(p);
  }
  return p!;
}

Packet makePacket(String bin) {
  var v = getID(bin);
  if (v == 4) {
    return ValuePacket(bin);
  } else {
    return OpPacket(bin);
  }
}

String toBin(String packet) {
  var s = '';
  for (var l in packet.split('')) {
    s += cmap[l]!;
  }
  return s;
}

int getID(String bin) {
  return int.parse(bin.substring(3, 6), radix: 2);
}

class ValuePacket extends Packet {
  ValuePacket(String bin) : super(bin) {}

  @override
  parse() {
    super.parse();
    var v = '';
    for (var i = 6; i < binary.length; i += 5) {
      v += binary.substring(i + 1, i + 5);
      if (binary[i] == '0') {
        value = int.parse(v, radix: 2);
        bitLength = i + 5;
        return;
      }
    }
  }

  @override
  String toString() {
    return super.toString() + ', value: $value}';
  }
}

class OpPacket extends Packet {
  String? lengthTypeID;
  int? subLength;
  int? subCount;
  List<Packet> subPackets = [];
  OpPacket(String bin) : super(bin) {
    lengthTypeID = bin[6];
    if (lengthTypeID == '0') {
      subLength = int.parse(bin.substring(7, 15 + 7), radix: 2);
    } else {
      subCount = int.parse(bin.substring(7, 11 + 7), radix: 2);
    }
    subPackets = makeSub();
  }
  @override
  String toString() {
    return super.toString() +
        ', lengthTypeID: $lengthTypeID, subLength: $subLength, subCount: $subCount, subPackets: $subPackets}';
  }

  List<Packet> makeSub() {
    List<Packet> subp = [];
    if (subLength != null) {
      bitLength = 7 + 15 + subLength!;
      print(bitLength);
      // print(subLength);
      // print(binary);
      var subBin = binary.substring(15 + 7, 15 + 7 + subLength!);
      while (subBin.length > 7) {
        var p = makePacket(subBin);
        subp.add(p);
        subBin = subBin.substring(p.bitLength);
      }
    } else {
      var subBin = binary.substring(11 + 7);
      bitLength = 11 + 7;
      for (var i = 0; i < subCount!; i++) {
        var p = makePacket(subBin);
        subp.add(p);
        subBin = subBin.substring(p.bitLength);
        bitLength += p.bitLength;
      }
    }
    return subp;
  }

  @override
  int getScore() {
    var score = version;
    for (var p in subPackets) {
      score += p.getScore();
    }
    return score;
  }

  get value {
    var map = {
      0: type0,
      1: type1,
      2: type2,
      3: type3,
      5: type5,
      6: type6,
      7: type7,
    };
    return map[typeID]!();
  }

  int type0() {
    var sum = 0;
    for (var p in subPackets) {
      sum += p.value;
    }
    return sum;
  }

  int type1() {
    var product = 1;
    for (var p in subPackets) {
      product *= p.value;
    }
    return product;
  }

  int type2() {
    var minv = 9999999999999999;
    for (var p in subPackets) {
      if (p.value < minv) {
        minv = p.value;
      }
    }
    return minv;
  }

  int type3() {
    var maxv = 0;
    for (var p in subPackets) {
      if (p.value > maxv) {
        maxv = p.value;
      }
    }
    return maxv;
  }

  int type5() {
    return subPackets[0].value > subPackets[1].value ? 1 : 0;
  }

  int type6() {
    return subPackets[0].value < subPackets[1].value ? 1 : 0;
  }

  int type7() {
    return subPackets[0].value == subPackets[1].value ? 1 : 0;
  }
}

class Packet {
  var typeID = 0;
  var version = 0;
  var binary = '';
  var bitLength = 0;
  var value = 0;
  Packet(String bin) {
    binary = bin;
    parse();
  }

  parse() {
    version = int.parse(binary.substring(0, 3), radix: 2);
    typeID = getID(binary);
  }

  int getScore() {
    return version;
  }

  @override
  String toString() {
    return '{typeID: $typeID, version: $version, bitLength: $bitLength, value: $value, score: ${getScore()}';
  }
}
