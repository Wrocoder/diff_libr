from collections import Counter

l = [1, 3, 2, 4, 5, 6, 7, 3, 2, 5, 6, 0, 3, 0, 22, 0, 5, 5, 5]

l_temp = [x for x in l if x != 5]

zero1 = l.count(5)
zero2 = Counter(l)[5]
print(zero1)
print(zero2)
l_add = [5 for item in range(zero2)]

print(l_add)
print(l_temp + l_add)

l_x = sorted(l, key=lambda x: x == 5)
print(l_x)

print(enumerate(l))


def tr(func):
    def wrapper(*args, **kwargs):
        print('first')
        result = func(*args, **kwargs)
        print('second')
        return result

    return wrapper


@tr
def fir():
    l = [1, 3, 2, 4, 5, 6, 7, 3, 2, 5, 6, 0, 3, 0, 22, 0, 5, 5, 5]
    for k, v in enumerate(l):
        print(k, v)


print(fir())


class Triangle:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    # @property
    def perim(self):
        return self.x + self.y + self.z

    def x2perim(self):
        return self.perim() * 2


tmp = Triangle(1, 3, 4)

print(tmp.perim())
print(tmp.x2perim())


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


languages = ['Java', 'Python', 'JavaScript']
versions = [14, 3, 6, 4]

result = zip(languages, versions)
print(list(result))

tmp = {23: [1, 2, 3, 4, 5, 'rty']}

t = (tmp, 'ddsd')

print(type(t))

# find two numbers with max sum
t = [3, 67, 6, 34, 54, 89, 76]


def max_nums(l: list) -> int:
    t = sorted(l, reverse=True)[0]
    e = sorted(l, reverse=True)[1]
    print(t)
    print(e)
    return t + e


print(max_nums(t))


x = [[]] * 3  # [[], [], []]
print(x)
x[1].append(1)   # [[1], [1], [1]]
print(x)