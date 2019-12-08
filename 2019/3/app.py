import math
def test():
    assert calc('R8,U5,L5,D3','U7,R6,D4,L4') == 6
    assert calc('R75,D30,R83,U83,L12,D49,R71,U7,L72', 'U62,R66,U55,R34,D71,R55,D58,R83') == 159
    assert calc('R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51', 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7') == 135

    assert calc2('R75,D30,R83,U83,L12,D49,R71,U7,L72','U62,R66,U55,R34,D71,R55,D58,R83') == 610
    assert calc2('R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51','U98,R91,D20,R16,D67,R40,U7,R15,U6,R7') == 410

def expand(c):
    a = [(0,0)]
    for b in c:
        if b[0] == 'R':
            for f in range(1, int(b[1:])+1):
                a.append((a[-1][0], a[-1][1] + 1))
        if b[0] == 'U':
            for f in range(1, int(b[1:])+1):
                a.append((a[-1][0] + 1, a[-1][1]))
        if b[0] == 'L':
            for f in range(1, int(b[1:])+1):
                a.append((a[-1][0], a[-1][1] - 1))
        if b[0] == 'D':
            for f in range(1, int(b[1:])+1):
                a.append((a[-1][0] - 1, a[-1][1]))
    return a

def calc(one, two):
    one = one.split(',')
    two = two.split(',')
    print(one, two)
    a = expand(one)
    b = expand(two)
    inter = set(a).intersection(set(b))
    inter.remove((0,0))
    print(inter)
    low = None
    for i in inter:
        if not low:
            low =  abs(i[0]) + abs(i[1])
        c = abs(i[0]) + abs(i[1])
        if c < low:
            low = c
    return low

def calc2(one, two):
    one = one.split(',')
    two = two.split(',')
    print(one, two)
    a = expand(one)
    b = expand(two)
    inter = set(a).intersection(set(b))
    inter.remove((0,0))
    low = None
    for i in inter:
        if not low:
            low =  a.index(i) + b.index(i)
        c = a.index(i) + b.index(i)
        if c < low:
            low = c
    return low

test()


inp = [a.strip() for a in open('input.txt').readlines() if a.strip()]

print(inp)
print(calc(inp[0], inp[1]))
print(calc2(inp[0], inp[1]))
# pg1[1] = 12
# pg1[2] = 2
# answer = calc(pg1)[0]
# print(answer)

# answer2 = calc2(inp.copy())
# print(100 * answer2[0] + answer2[1])