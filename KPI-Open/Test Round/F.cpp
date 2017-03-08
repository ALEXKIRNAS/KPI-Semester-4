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
#include <memory.h>
using namespace std;

const int Nmax = 1e2 + 17;
const int mod = 1e9 + 7;

char s[Nmax][Nmax];
int sum[Nmax][Nmax] = {};


void dfs(int n, int m) {
	for (int i = 0; i < n; i++)
		for (int z = 0; z < m; z++) {
			if (i + z == 0) continue;
			sum[i][z] = -1;
			if (s[i][z] == '#') continue;

			if (i > 0)
				sum[i][z] = max(sum[i][z], sum[i - 1][z]);
			if (z > 0)
				sum[i][z] = max(sum[i][z], sum[i][z - 1]);

			if (s[i][z] == '*' && sum[i][z] != -1) sum[i][z]++;
		}
}

int main(void) {
	//freopen("input.txt", "r", stdin);
	int n, m;

	scanf("%d%d", &n, &m);
	for (int i = 0; i < n; i++)
		scanf("%s", &s[i]);

	if (s[0][0] == '*')
		sum[0][0] = 1;

	dfs(n, m);

	/*for (int i = 0; i < n; i++, printf("\n"))
		for (int z = 0; z < m; z++)
			printf("%4d", sum[i][z]);*/

	if (sum[n - 1][m - 1] == -1) {
		printf("-1");
	}
	else {
		int ans = sum[n - 1][m - 1];
		int x = n - 1, y = m - 1;
		while (x || y) {
			if (s[x][y] == '*') s[x][y] = '.';
			if (x == 0) y--;
			else if (y == 0) x--;
			else if (sum[x - 1][y] > sum[x][y - 1]) x--;
			else y--;
		}

		memset(sum, 0, sizeof(sum));
		dfs(n, m);

		ans += sum[n - 1][m - 1];
		printf("%d", ans);
	}
}