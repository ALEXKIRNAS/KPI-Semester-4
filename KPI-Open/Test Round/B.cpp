#include <cstdio>
#include <iostream>
#include <cmath>
#include <ctime>
#include <cstdlib>
#include <algorithm>
#include <functional>
#include <vector>
#include <set>
#include <map>
#include <cstring>
using namespace std;

const int Nmax = 1e7 + 17;
const int mod = 1e9 + 7;

long long a[5] = {};

long long gcd(long long a, long long b) {
	while (a && b)
		if (a > b)
			a %= b;
		else
			b %= a;
	return a + b;
}


int main(void) {
	//freopen("input.txt", "r", stdin);

	int n;
	scanf("%d", &n);

	for (int i = 0; i < n; i++)
		cin >> a[i];
	
	
	long long ans = a[0];
	for (int i = 1; i < n; i++)
		ans =  ans * a[i] / gcd(ans, a[i]);

	cout << ans;
}