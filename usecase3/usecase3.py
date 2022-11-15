
# data = dict(input("Please enter the dataset"))
data_dummy=dict({"a":{"b":{"c":"d"}}})

# key = input("Please enter the key")
key_dummy = "a/b/c"

key_dummy_list = key_dummy.split("/")

for i in key_dummy_list:
    if i == list(data_dummy.keys())[0]:
        data_dummy = data_dummy[i]
    else:
        print("Key doesn't match the data provided. Some discrepancy to be corrected")
        break
print(data_dummy)
