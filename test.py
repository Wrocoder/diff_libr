list1 = []

def app_list(sp):
    sp.append(5)
    sp.append(6)
    return sp


print(app_list(list1))
print(list1)

a = 5

def temp(a):
    a += 1
    return a

print(temp(a))

print(a)



def f():
    num = 10
    def g():
        return num
    num = 20
    return g()

temp = f()
print(temp)

print(f)
print(f())


r = {'ser', 1, 4}
e = {'ser', 1, 4}
print(type(r))
r.add(3)
print(r)
print(e == r)




r = ('ser', 1, 4)
e = ('ser', 1, 4)
print(type(r))
print(r.count(1))
print(r)
print(e == r)