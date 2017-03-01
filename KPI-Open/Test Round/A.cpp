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

int a[10] = {};


int main(void) {
	//freopen("input.txt", "r", stdin);

	int n, x;
	scanf("%d", &n);
	for (int i = 0; i < n; i++) {
		scanf("%d", &x);
		a[x]++;
	}
	int ans = a[1];
	for (int i = 2; i <= 6; i++)
		ans = min(ans, a[i]);
	printf("%d", ans + 2);
}