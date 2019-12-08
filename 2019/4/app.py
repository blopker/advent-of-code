import math
def test():
    assert calc(111111) == True
    assert calc(223450) == False
    assert calc(123789) == False
    assert calc2(112233) == True
    assert calc2(112233) == True
    assert calc2(123444) == False
    assert calc2(111122) == True
    assert calc2(799999) == False


def calc(i):
    s = str(i)
    if len(s) != 6:
        return False
    for x in range(5):
        if s[x] == s[x+1]:
            break
    else:
        return False
    for x in range(1, 6):
        # print(x)
        if int(s[x-1]) > int(s[x]):
            return False
    return True


def calc2(i):
    if not calc(i):
        return False
    s = str(i)
    if s[0] == s[1] != s[2]:
        return True
    if s[1] == s[2] and s[1] != s[3] and s[1] != s[0]:
        print(i)
        return True
    if s[2] == s[3] and s[2] != s[1] and s[2] != s[4]:
        return True
    if s[3] == s[4] and s[3] != s[2] and s[3] != s[5]:
        return True
    if s[4] == s[5] and s[4] != s[3]:
        return True
    return False


test()

# f = 0
# for c in range(353096,843212):
#     if calc(c):
#         print(c)
#         f+=1

# print(f)

f = 0
for c in range(353096,843212):
    if calc2(c):
        print(c)
        f+=1

print(f)
# inp = [a.strip() for a in open('input.txt').readlines() if a.strip()]

# print(inp)
# print(calc(inp[0], inp[1]))
# print(calc2(inp[0], inp[1]))
# pg1[1] = 12
# pg1[2] = 2
# answer = calc(pg1)[0]
# print(answer)

# answer2 = calc2(inp.copy())
# print(100 * answer2[0] + answer2[1])