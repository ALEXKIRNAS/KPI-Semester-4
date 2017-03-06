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

const int Nmax = 130;
const int Mmax = 1e3 + 1;
const int mod = 1e9 + 7;

#define min(x, y) (x < y ? x : y)

char dp[Nmax][Mmax][Mmax - 1];
short a[Nmax];

int main(void) {
	//freopen("input.txt", "r", stdin);

	int n;
	cin >> n;

	a[0] = 1;
	for (int i = 1; i < Nmax; i++)
		a[i] = (a[i - 1] * 10) % n;

	if (n < 10) {
		cout << n;
	}
	else {
		memset(dp, -1, sizeof(dp));
		for (int z = 0; z < 10; z++)
			dp[0][z][z] = z;

		int i = 0;
		do {
			int range = min((i + 1) * 10, n);
			int br = max(0, n - (Nmax - i) * 9);
			for (int k = br; k < range; k++)
				for (int z = 0; z < n; z++)
					if (dp[i][k][z] != -1)
						for (int j = 0; j < 10; j++) {
							if (k + j > n) break;
							int x = (z + j * a[i + 1]) % n;

							if (x + j == 0 && k == n) continue;
							dp[i + 1][k + j][x] = j;
						}

			i++;
		} while (dp[i][n][0] == -1);

		int x = dp[i][n][0];
		int y = 0;
		int z = n;
		while (i != 0) {
			printf("%d", x);
			z -= x;
			y -= x * a[i];
			while (y < 0) y += n;
			x = dp[--i][z][y];
		}
		printf("%d", x);
	}

}