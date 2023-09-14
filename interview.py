# import random
#
#
# def shuffle_list(l):
#     return random.shuffle
#
#
# list_elements = [1, 2, 3, 4, 5, 6, 7, 87, 'q', 'e', 'y']
# shuffle_list(list_elements)
#
# print(list_elements)
import functools


def wrapper(func):
    @functools.wraps(func)
    def inner_func(*args, **kwargs):
        print('Hi men')
        x = func(*args, **kwargs)
        print('Bay men')
        return x + 8

    return inner_func


class Car:
    def __init__(self, kind, mark, color):
        self.kind = kind
        self.mark = mark
        self.color = color

    # def __str__(self):
    #     return f'This is {self.kind} - {self.mark}, with {self.color} color'

    def __repr__(self):
        return f'{self.kind} - {self.mark} - {self.color}'

    def __cls__(self):
        pass

    @wrapper
    def xyz(self, number):
        return number + 2


abc = Car('Big', 'BNW', 'black')

print(abc.__str__())

print(abc.__repr__())

print(abc.__str__)

print(abc.__repr__)

print(abc.xyz(1))

print(abc.kind)
print(abc.mark)
print(abc.color)


class Bus(Car):
    def __init__(self, count_seats, kind, mark, color):
        super().__init__(kind, mark, color)
        self.count_seats = count_seats


bbb = Bus(kind='small', mark='vw', color='yellow', count_seats=42)

print(bbb.color)
print(bbb.count_seats)
print(bbb.__repr__())
