n = int(input())

high = int(pow(n, 1/3.0))
ans = 0l
c = 1
while c <= high:
    k = int(pow(n - c * c * c, 1/2.0))
    ans += k * n - k * c * c * c - (k * (k + 1) * (2*k + 1)) / 6
    c = c + 1
                          
print ans