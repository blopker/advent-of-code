def test():
    assert calc(12) == 2
    assert calc(14) == 2
    assert calc(1969) == 654
    assert calc(100756) == 33583

    assert calc_2(12) == 2
    # assert calc_2(1969) == 966
    # assert calc_2(100756) == 50346

def calc(i):
    return i // 3 - 2 

def calc_2(i, s=0):
    if i == 0:
        return s
    a = max(i // 3 - 2, 0)
    s += a
    # return 0
    return calc_2(a, s)
test()


inp = [int(a.strip()) for a in open('input.txt').readlines() if a.strip()]

answer = sum(calc(a) for a in inp)
print(answer)

answer2 = sum(calc_2(a) for a in inp)
print(answer2)
