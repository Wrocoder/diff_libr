"""
Create class with next operations
- adding value
- getting value, in case it does not exists return None
- removing value, in case it does not exists do nothing
- getting random value from stored, in case container is empty return None
! ALL METHODS SHOULD HAVE CONSTANT TIME COMPLEXITY - O(1)
"""
import abc


class IContainer(abc.ABC):
    @abc.abstractmethod
    def add(self, value: int) -> None:
        pass

    @abc.abstractmethod
    def get(self, value: int) -> int | None:
        pass

    @abc.abstractmethod
    def remove(self, value: int) -> int:
        pass

    @abc.abstractmethod
    def get_random(self) -> int | None:
        pass


import random


class Temp():

    def __init__(self):
        self.temp_list = []
        self.temp_dict = dict()

    def add(self, el: str) -> None:
        self.temp_dict[len(self.temp_list)] = el
        self.temp_list.append(el)

    def get(self, el: str) -> int or None:
        if self.temp_list.index(el) in self.temp_dict:
            return self.temp_dict.get(self.temp_list.index(el)) if el in self.temp_dict.values() else None

    def remove(self, el: str) -> None:
        if el in self.temp_list:
            self.temp_dict.pop(self.temp_list.index(el))
            print(self.temp_list)
            self.temp_list[self.temp_list.index(el)], self.temp_list[-1] = self.temp_list[-1], \
                self.temp_list[self.temp_list.index(el)]
            print(self.temp_list)
            self.temp_list.pop()

    def get_random(self) -> str:
        ind = random.randint(0, len(self.temp_list) - 1)
        return self.temp_list[ind]

    def show(self):
        print(f'list {self.temp_list}')
        print(f'dict {self.temp_dict}')


tr = Temp()
tr.add(12)
tr.add(11)
tr.add(15)
tr.add(3)
tr.add('qwert')

tr.show()

print(tr.get(11))
tr.show()

tr.remove(15)
tr.show()

print(tr.get_random())
tr.show()
