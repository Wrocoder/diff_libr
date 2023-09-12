call_count = 0


def count_calls(func):
    def wrapper(*args, **kwargs):
        global call_count
        call_count += 1
        print(f"Call {call_count} to {func.__name__}")
        return func(*args, **kwargs)

    return wrapper


@count_calls
def say_hello(name):
    return f"Hi, {name}!"


@count_calls
def add(a, b):
    return a + b


print(say_hello("Alice"))
print(add(2, 3))
print(say_hello("Bob"))
