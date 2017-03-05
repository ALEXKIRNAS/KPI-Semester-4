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
int q[Nmax] = {};
int w[Nmax] = {};

int sum(int* t, int r) {
	int result = 0;
	for (; r >= 0; r = (r & (r + 1)) - 1)
		result += t[r];
	return result;
}

void inc(int* t, int i, int delta) {
	for (; i < Nmax; i = (i | (i + 1)))
		t[i] += delta;
}

int sum(int* t, int l, int r) {
	return sum(t, r) - sum(t, l - 1);
}


int main(void) {
	//freopen("input.txt", "r", stdin);

	int n, m;
	scanf("%d%d", &n, &m);
	for (int i = 0; i < n; i++)
		scanf("%d", &a[i]);

	long long ans = 0;
	int bal = 0;
	inc(q, 0, 1);

	for (int i = 0; i < n; i++) {
		bal += (a[i] >= m ? 1 : -1);

		if (bal > 0) ans += sum(q, 0, bal - 1) + sum(w, 0, Nmax - 2);
		else if (bal == 0) ans += sum(w, 0, Nmax - 2);
		else ans += sum(w, abs(bal) + 1, Nmax - 2);

		if (bal >= 0) inc(q, bal, 1);
		else inc(w, abs(bal), 1);
	}


	cout << ans;
}