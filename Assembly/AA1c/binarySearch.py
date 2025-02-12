
# def largest_to_smallest(array):
#     if array[0] > array[-1]:
#         return True

# # smallest to largest
# def recursive_binary_search(target, array, start, end):
#     # base case
#     if start > end:
#         return -1
    
#     mid = (start + end)//2

#     if target == array[mid]:
#         return mid
#     elif target > array[mid]:
#         # smaller to larger
#         if largest_to_smallest(array):
#             return recursive_binary_search(target, array, start, mid-1)
#         else:
#             return recursive_binary_search(target, array, mid+1, end)
    
#     else:
#         if largest_to_smallest(array):
#             return recursive_binary_search(target, array, mid+1, end)
#         else:
#             return recursive_binary_search(target, array, start, mid-1)


# def testing_binary_search(target, size, array, correctIndex):
#     search_result = recursive_binary_search(target, array, 0, size-1)
#     if search_result == correctIndex:
#         print("OK")
#     else:
#         print("Testcase not passing.")

def largest_to_smallest(array):
    # Check if the array is sorted in descending order
    return array[0] > array[-1]

# Ascending binary search
def ascending_recursive_binary_search(target, array, start, end):
    # Base case: target not found
    if start > end:
        return -1
    
    mid = (start + end) // 2

    if target == array[mid]:
        return mid
    elif target < array[mid]:
        # Search the left half
        return ascending_recursive_binary_search(target, array, start, mid - 1)
    else:
        # Search the right half
        return ascending_recursive_binary_search(target, array, mid + 1, end)

# Descending binary search
def descending_recursive_binary_search(target, array, start, end):
    # Base case: target not found
    if start > end:
        return -1
    
    mid = (start + end) // 2

    if target == array[mid]:
        return mid
    elif target > array[mid]:
        # Search the left half
        return descending_recursive_binary_search(target, array, start, mid - 1)
    else:
        # Search the right half
        return descending_recursive_binary_search(target, array, mid + 1, end)

# Main function to determine ascending or descending and call respective search
def recursive_binary_search(target, array):
    if largest_to_smallest(array):
        # If the array is sorted in descending order
        return descending_recursive_binary_search(target, array, 0, len(array) - 1)
    else:
        # If the array is sorted in ascending order
        return ascending_recursive_binary_search(target, array, 0, len(array) - 1)

# Testing function
def testing_binary_search(target, size, array, correctIndex):
    search_result = recursive_binary_search(target, array)
    if search_result == correctIndex:
        print("OK")
    else:
        print("Testcase not passing.")

# testing for smallest to largest
testing_binary_search(25, 5, [0, 10, 20, 30, 40], -1)
testing_binary_search(20, 4, [0, 10, 20, 30], 2)
# testing for largest to smallest
testing_binary_search(25, 5, [40, 30, 20, 10, 0], -1)
testing_binary_search(20, 4, [30, 20, 10, 0], 1)
