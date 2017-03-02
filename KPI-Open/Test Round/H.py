n = int(input())

high = int(pow(n, 1/3.0))
ans = 0

for c in range(1, high + 1):
    k = int(pow(n - pow(c, 3), 1/2.0))
    ans += k * n - k * pow(c, 3) - (k * (k + 1) * (2*k + 1)) / 6
    
print(ans)