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
#include <iomanip>
using namespace std;

const int Nmax = 1e5 + 17;
const int mod = 1e9 + 7;

int a[Nmax];

int main(void) {
	//freopen("input.txt", "r", stdin);

	int n, m;
	scanf("%d%d", &n, &m);
	for (int i = 0; i < n; i++)
		scanf("%d", &a[i]);

	long long ans = 0;
	for(int i = 0; i < n; i++)
		if (a[i] >= m) {
			int low = i;
			int high = n - i - 1;

			ans += min(high, low) * 2 + 1;
			if (high > low) ans++;
		}

	cout << ans;
}