# Write a following class:

# 1. it should have attributes: n, lower_bound, upper_bound (all integers)
# 2. init method should generate list of random integers of length n within lower_bound and upper_bound
# (using “random” library)
# 3. class should have property methods that compute mean and variance of list generated
# in init (without using “side” libraries, like NumPy etc.)
# 4. when you call “print” or refer to class instance, it should print out generated list


# Эта задача решена, только без добавления декоратора @property для двух методов
from random import randint


class RandomList:
    def __init__(self, n, lower_bound, upper_bound):
        self.n = n
        self.lower_bound = lower_bound
        self.upper_bound = upper_bound
        self.temp_list = [randint(self.lower_bound, self.upper_bound) for x in range(n)]

    # Ex = sum(x) / n

    # Dx = sum(x - Ex)**2 / n
    @property
    def mean(self):
        temp = 0
        for item in self.temp_list:
            temp += item

        return temp / self.n

    @property
    def variance(self):
        temp_sum = self.mean
        return sum((x - temp_sum) ** 2 for x in self.temp_list) / (self.n - 1)


l = RandomList(n=5, lower_bound=0, upper_bound=100)
# generates list

print(l)
# [22, 78, 50, 47, 98]
print(l.mean)
# 59.0
print(l.variance)
# 695.2


# Given an integer array nums and an integer k, return the k most frequent elements

"""Эта задача мной не решена (создал дикт в котором ключ это число, а значение это каунт, сколько раз ключ встречается в
списке), предлогал решить с помощью Counter из collections, и хотел посмотреть в документацию collections,
интервьюер запретил пользоваться документацией. Знал что в Counter есть какой то метод для вывода наиболее 
встречающихся элементов"""
def k_most_frequent_elements(nums, k):
    frequency_dict = {}

    # Count the frequency of each element
    for num in nums:
        if num in frequency_dict:
            frequency_dict[num] += 1
        else:
            frequency_dict[num] = 1

    # Sort the dictionary items by frequency in descending order
    sorted_items = sorted(frequency_dict.items(), key=lambda x: x[1], reverse=True)

    # Extract the k most frequent elements
    result = [item[0] for item in sorted_items[:k]]

    return result


tr = [1, 2, 2, 3, 3, 3, 4, 5, 6]
k = 2

print(k_most_frequent_elements(tr, k))
# ==> [2, 3]


# SQL:

# Table Employee
# +-------------+---------+
# | Column
# | Name         | Type    |
# +-------------+---------+
# | Id           | int     |
# | Name         | varchar |
# | Salary       | int     |
# | ManagerId    | int     |
# | DepartmentId | int     |
# +-------------+---------+
#
# +----+-------+--------+-----------+--------------+
# | Id | Name | Salary | ManagerId | DepartmentId |
# +----+-------+--------+-----------+--------------+
# | 1 | Joe   | 70000  | 3         | 1            |
# | 2 | Henry | 80000  | 4         | 1            |
# | 3 | Sam   | 60000  | Null      | 2            |
# | 4 | Max   | 90000  | Null      | 3            |
# +----+-------+--------+-----------+--------------+
#
# Тут все три задачи решил за 10-15 минут, в первой сразу забыл про salary difference, потом дописал
#
# 1. Select all employees with salary higher than their managers.Select id, manager's id, salary difference
# 2. Select average salary in each department with ≥ 5 employees (DepartmentId, average salary)
# 3. Select top - 3 employees by salary in each department(id, DepartmentId, salary, rank)
#
# 1.select e1.id,
#           e1.manager_id,
#           (e1.salary - e2.salary) as salary_difference
#     from Employee e1
#     join Employee e2
#     on e1.Id = e2.ManagerId
#     where e2.sqlary > e1.salary;
#
# 2.select DepartmentId, avg(salary) from employees
#           group by DepartmentId
#           having count(Name) >= 5;
#
# 3.with CTE as
#       ( select  Id, Name, Salary, ManagerId, DepartmentId,
#       rank() over(partition by DepartmentId order by salary desc) as ran from Employees )
#       select id, DepartmentId, Salary, rank from CTE where ran <= 3
#

# Еще главный фэйл на интервью, забыл как перевести слово "frequent" во втором таске по питону (долго тупил ~ 5 мин)
# Задачи ни как не запускались, все писалось в каком то онлайн текстовом редакторе