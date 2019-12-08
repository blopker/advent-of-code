def test():
    assert calc([1,0,0,0,99]) == [2,0,0,0,99]
    assert calc([2,3,0,3,99]) == [2,3,0,6,99]
    assert calc([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
    assert calc([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
    assert calc([1,9,10,3,2,3,11,0,99,30,40,50]) == [3500,9,10,70,2,3,11,0,99,30,40,50]
    assert parse_op([1001, 224, -650, 224], 0) == {'code': 1, 'params': [(224, 0), (-650, 1), (224, 0)], 'size': 3}
    assert calc([3,9,8,9,10,9,4,9,99,-1,8])
    assert calc([3,9,7,9,10,9,4,9,99,-1,8])
    assert calc([3,3,1108,-1,8,3,4,3,99])
    assert calc([3,3,1107,-1,8,3,4,3,99],1)
    assert calc([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
    assert calc([3,3,1105,-1,9,1101,0,0,12,4,12,99,1])
    assert calc([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], 0, True) == 999
    assert calc([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], 8, True) == 1000
    assert calc([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], 10, True) == 1001

DBUG = False

def debug(s):
    if DBUG:
        print(s)

def parse_op(pgm, idx):
    instruciton = pgm[idx]
    code = instruciton % 100
    code_size = {
        1: 3,
        2: 3,
        3: 1,
        4: 1,
        5: 2,
        6: 2,
        7: 3,
        8: 3
    }[code]
    debug(pgm[:(idx + 10)])
    params = []
    for a in range(code_size):
        param_mode = instruciton//10**(a+2)%10
        params.append((pgm[idx+a+1], param_mode))
    return {
        'code': code,
        'params': params,
        'size': code_size
    }


def get_param(pgm, param):
    debug(param)
    if param[1] == 0:
        return pgm[param[0]]
    if param[1] == 1:
        return param[0]


def run_op(pgm, idx, inp):
    op = parse_op(pgm, idx)
    debug(idx)
    debug(op)
    out = None
    if op['code'] == 1:
        pgm[op['params'][2][0]] = get_param(pgm, op['params'][0]) + get_param(pgm, op['params'][1])
    if op['code'] == 2:
        pgm[op['params'][2][0]] = get_param(pgm, op['params'][0]) * get_param(pgm, op['params'][1])
    if op['code'] == 3:
        pgm[op['params'][0][0]] = inp
    if op['code'] == 4:
        out = get_param(pgm, op['params'][0])
    if op['code'] == 5:
        if get_param(pgm, op['params'][0]) != 0:
            return get_param(pgm, op['params'][1]), out
    if op['code'] == 6:
        if get_param(pgm, op['params'][0]) == 0:
            return get_param(pgm, op['params'][1]), out
    if op['code'] == 7:
        if get_param(pgm, op['params'][0]) < get_param(pgm, op['params'][1]):
            pgm[op['params'][2][0]] = 1    
        else:
            pgm[op['params'][2][0]] = 0
    if op['code'] == 8:
        if get_param(pgm, op['params'][0]) == get_param(pgm, op['params'][1]):
            pgm[op['params'][2][0]] = 1    
        else:
            pgm[op['params'][2][0]] = 0
    return idx + op['size'] + 1, out


def calc(pgm, i=0, return_out=False):
    print(pgm)
    idx, out = run_op(pgm, 0, i)
    while pgm[idx] is not 99:
        idx, out1 = run_op(pgm, idx, i)
        if out1 is not None:
            out = out1
            print('OUTPUT: %s' %out)
    debug(pgm)
    if return_out:
        return out
    return pgm

test()


inp = [int(a.strip()) for a in open('input.txt').readlines()[0].split(',') if a.strip()]
calc(inp.copy(), 1)
calc(inp.copy(), 5)