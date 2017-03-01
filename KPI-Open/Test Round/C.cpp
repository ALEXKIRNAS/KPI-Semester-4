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

const int Nmax = 1e2 + 17;
const int mod = 1e9 + 7;

double a[Nmax];
const double g = 9.81;

int main(void) {
	//freopen("input.txt", "r", stdin);

	int n;
	double v;
	cin >> v >> n;

	for (int i = 0; i < n; i++)
		cin >> a[i];
	
	sort(a, a + n);
	for (int i = 0; i < n; i++)
		printf("%.2Lf\n", (a[i] * a[i]) * g / (2 * v * v));
}