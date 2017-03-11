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

const int Nmax = 43;
const int Mmax = 1e3 + 1;
const int mod = 1e9 + 7;

int a[Nmax] = {};

void add(int sum, int x, vector <int> &q) {
	if (a[x] > sum) {
		q.push_back(x);
		a[x] = sum;
	}
}

int main(void) {
	//freopen("input.txt", "r", stdin);

	for (int i = 1; i < Nmax; i++)
		a[i] = Nmax;

	vector <int> q;
	q.push_back(1);
	a[1] = 0;

	int index = 0;
	while (index < q.size()) {
		int x = q[index++];
		for (int z = x * 2; z < Nmax; z *= 2)
			add(a[x] + 1, z, q);
		for (int i = 1; i < Nmax; i++)
			add(a[i] + a[x] + 1, i + x, q);
		for (int i = Nmax - 1; i > x; i--)
			add(a[i] + a[x] + 1, i - x, q);
	}

	/*for (int i = 1; i < Nmax; i++)
		printf("%d\t-\t%d\n", i, a[i]); */

	for (int i = 0; i < 6; i++) {
		printf("\n\n%d:\n", i);
		for (int z = 0; z < Nmax; z++)
			if (a[z] == i) printf("\t%d\n", z);
	}
}