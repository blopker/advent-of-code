def test():
    assert calc([1,0,0,0,99]) == [2,0,0,0,99]
    assert calc([2,3,0,3,99]) == [2,3,0,6,99]
    assert calc([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    assert calc([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
    assert calc([1,9,10,3,2,3,11,0,99,30,40,50]) == [3500,9,10,70,2,3,11,0,99,30,40,50]


def calc(arr):
    arr = list(arr)
    for i in range(len(arr)//4 + 1):
        # print(arr)
        i = i * 4
        o = arr[i]
        # print(o, i)
        if o == 99:
            return arr
        a = arr[i+1]
        b = arr[i+2]
        c = arr[i+3]
        # print(a,b,c)
        if o == 1:
            arr[c] = arr[a] + arr[b]
        if o == 2:
            arr[c] = arr[a] * arr[b]        

test()

def calc2(arr):
    for a in range(99):
        for b in range(99):
            arrc = arr.copy()
            arrc[1] = a
            arrc[2] = b
            if calc(arrc)[0] == 19690720:
                return a, b


inp = [int(a.strip()) for a in open('input.txt').readlines()[0].split(',') if a.strip()]
print(inp)
pg1 = inp.copy()
pg1[1] = 12
pg1[2] = 2
answer = calc(pg1)[0]
print(answer)

answer2 = calc2(inp.copy())
print(100 * answer2[0] + answer2[1])