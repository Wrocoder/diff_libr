from color_game_logger.logger import setup_colored_logger

logger = setup_colored_logger()

temp_list = [1, 2, 3, 4, 5, 6, 7, 8, 9]

res = 12


# find numbers in the list that add up to the given result (res)

def find_nums(arr_nums: list, res: int):
    res_list = []
    for item in arr_nums:
        temp = res - item
        if temp in arr_nums[arr_nums.index(item) + 1:]:
            print(item)
            logger.info(f"{item} + {temp} = {res}")
            res_list.append([item, temp])
        else:
            pass

    return res_list

print(find_nums(temp_list, res))
