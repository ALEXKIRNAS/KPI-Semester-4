n = int(input().split()[0])

a = [1] * 50 

for i in range(2, n):
	a[i] = a[i-1] + a[i-2]
	
print(a[n-1])