# Класс для управления банковским счетом:
# Создайте класс BankAccount, который имеет атрибуты account_number, account_holder, и balance. Реализуйте методы для пополнения (deposit) и снятия (withdraw) денег с счета, а также метод для проверки баланса (get_balance).

class BankAccount:
    def __init__(self, account_number, account_holder, balance):
        self.account_number = account_number
        self.account_holder = account_holder
        self.balance = balance

    def deposit(self, add):
        if add > 0:
            self.balance += add
            print(f"added {add}")
        else:
            print(f"You can't add zero or negative value - {add}")

    def withdraw(self, withdr):
        if self.balance - withdr >= 0:
            self.balance -= withdr
            print(f"got {withdr}")
        else:
            print(f"You can't get this sum")
            print(f"Max withdraw is {self.balance}")

    def get_balance(self):
        print(self.balance)
        return self.balance

    def __repr__(self):
        return f"acc_numb - {self.account_number} \nholder - {self.account_holder} \nbalance - {self.balance}"


# temp = BankAccount(12345, "Dmitriy", 0)
# print(temp)
# print(temp.deposit(10))
# print(temp.withdraw(5))
# print(temp)
# print(temp.withdraw(10))
# print(temp.deposit(15))
# print(temp.get_balance())
# print(temp)

# Класс для работы с книгами:
# Создайте класс Book с атрибутами title, author, и publication_year. Затем создайте методы для получения информации о книге, например, get_title(), get_author(), и get_publication_year().
class Book:
    def __init__(self, title, author, publication_year):
        self.title = title
        self.author = author
        self.publication_year = publication_year

    def get_title(self):
        return self.title

    def get_author(self):
        return self.author

    def get_publication_year(self):
        return self.publication_year


# tru = Book("First book", "Stiven King", 1990)
#
# print(tru.get_title())
# print(tru.get_author())
# print(tru.get_publication_year())

# Класс для управления задачами (To-Do List):
# Разработайте класс Task для представления задачи с атрибутами, такими как description, due_date, и status. Затем создайте класс TaskList, который позволяет добавлять, удалять и отмечать задачи как выполненные.
class Task:
    def __init__(self, description, due_date):
        self.description = description
        self.due_date = due_date
        self.status = "Incomplete"

    def mark_as_done(self):
        self.status = "Complete"

    def __str__(self):
        return f"Description: {self.description}\nDue Date: {self.due_date}\nStatus: {self.status}"


class TaskList:
    def __init__(self):
        self.tasks = []

    def add_task(self, task):
        if isinstance(task, Task):
            self.tasks.append(task)
        else:
            print("Invalid task object. Please provide a Task instance.")

    def remove_task(self, task):
        if task in self.tasks:
            self.tasks.remove(task)
        else:
            print("Task not found in the list.")

    def list_tasks(self):
        for task in self.tasks:
            print(task)

    def mark_task_as_done(self, task):
        if task in self.tasks:
            task.mark_as_done()
        else:
            print("Task not found in the list.")


# task1 = Task("Buy groceries", "2023-09-15")
# task2 = Task("Finish project", "2023-09-30")
#
# task_list = TaskList()
# task_list.add_task(task1)
# task_list.add_task(task2)
#
# print("Tasks:")
# task_list.list_tasks()
#
# print("\nMarking task as done:")
# task_list.mark_task_as_done(task1)
#
# print("\nUpdated Tasks:")
# task_list.list_tasks()
#
# print("\nRemoving task:")
# task_list.remove_task(task2)
#
# print("\nFinal Task List:")
# task_list.list_tasks()


# Класс для анализа данных:
# Создайте класс DataAnalyzer, который принимает на вход список чисел и предоставляет методы для вычисления среднего значения (calculate_mean()), медианы (calculate_median()), и стандартного отклонения (calculate_stddev()).
import statistics


class DataAnalyzer:
    def __init__(self, list_numb):
        self.list_numb = list_numb

    def calculate_mean(self):
        return statistics.mean(self.list_numb)

    def calculate_median(self):
        return statistics.median(self.list_numb)

    def calculate_stddev(self):
        return statistics.stdev(self.list_numb)


# Класс для управления инвентарем товаров:
# Разработайте класс InventoryItem для представления товара с атрибутами, такими как product_id, product_name, и quantity_in_stock. Добавьте методы для увеличения и уменьшения количества товаров.
class InventoryItem:
    def __init__(self, product_id, product_name):
        self.product_id = product_id
        self.product_name = product_name
        self.quantity_in_stock = 0

    def increase_quantity(self, cnt):
        self.quantity_in_stock = self.quantity_in_stock + cnt
        return self.quantity_in_stock

    def decrease_quantity(self, inc_cnt):
        if self.quantity_in_stock >= inc_cnt:
            self.quantity_in_stock = self.quantity_in_stock - inc_cnt
            return self.quantity_in_stock
        else:
            print('not enough')


lst = []

from copy import deepcopy


def first(lst):
    lst.append(1)


def second(lst):
    l = deepcopy(lst)
    l.append(2)


first(lst)
second(lst)
lst.append(3)


# print(lst)
#
# n = 7

def in_thousend(n):
    lst = [item for item in range(0, 1000)]

    lst1 = [x for x in lst if x % 10 == 7]

    print(lst1)

    lst2 = [x for x in lst1 if x / 700 == 1]

    print(lst2)

    lst3 = [x for x in lst2 if x % 10 == 700]

    print(lst3)


# in_thousend(n)
#
#
# n = 'test asd'
# print(n.split(' '))


class Auto:
    def __init__(self, model, color, max_speed):
        self.model = model
        self.color = color
        self.max_speed = max_speed

    def avg_speed(self):
        return round(self.max_speed / 2, 2)


class Bus(Auto):
    def __init__(self, seats, model, color, max_speed):
        super().__init__(model, color, max_speed)
        self.seats = seats

    def __repr__(self):
        return (f'Seats in the Bus = {self.seats}')


t = Bus(42, 'bnw', 'green', 247)

print(t.avg_speed())