def anagram(l):
    ddd = {}
    for i in l:
        var = ''.join(sorted(list(i)))

        if var in ddd.keys():
            ddd[var].append(i)
        else:
            ddd[var] = [i, ]

    res = ddd.values()
    return tuple(list(res))


strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
strs = ["hi", "hello", "bye", "helol", "abc", "cab", "bac", "silenced", "licensed", "declines"]

print(anagram(strs))

from collections import Counter, defaultdict


def an(v1, v2):
    print(Counter(v1))
    print(Counter(v2))

    return Counter(v1) == Counter(v2)


var1 = 'hello'
var2 = 'llohe'
print(an(var1, var2))


def an(s1, s2):
    tr1 = sorted(list(s1))
    tr2 = sorted(list(s2))
    return tr1 == tr2


var1 = 'hello'
var2 = 'llohe'
print(an(var1, var2))



c = 'asdfasdfasdfasdfasdfasdfasdfasdfasdsdsdsaaaasdf'

print(Counter(c).most_common(4))


print(''.join(sorted(Counter(c).elements())))

import functools


def srapper(func):
    @functools.wraps(func)
    def inner_f(*args, **kwargs):

        return func(*args, **kwargs)

    return inner_f



