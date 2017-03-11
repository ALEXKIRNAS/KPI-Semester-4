#include <cstdio>
#include <iostream>
#include <memory.h>
using namespace std;

const int Nmax = 101;

#define max(a, b) (a > b ? a : b)

char s[Nmax][Nmax];
char cs[Nmax][Nmax];
int sum[Nmax - 1][Nmax - 1];
int csum[Nmax - 1][Nmax - 1];


void dfs(int l, int r, int& n, int& m, bool erase) {
	if (erase) memset(sum, 0, sizeof(sum));
	if (s[l][r] == '*') sum[l][r]++;

	for (int i = l; i <= n; i++)
		for (int z = r; z <= m; z++) {
			if (i + z == l + r) continue;
			sum[i][z] = -1;
			if (s[i][z] == '#') continue;

			if (i > l)
				sum[i][z] = max(sum[i][z], sum[i - 1][z]);
			if (z > r)
				sum[i][z] = max(sum[i][z], sum[i][z - 1]);

			if (s[i][z] == '*' && sum[i][z] != -1) sum[i][z]++;
		}
}

void delPath(int l, int r, int x, int y) {
	while (x != l || y != r) {
		if (s[x][y] == '*') s[x][y] = '.';
		if (x == l) y--;
		else if (y == r) x--;
		else if (sum[x - 1][y] > sum[x][y - 1]) x--;
		else y--;
	}
	if (s[x][y] == '*') s[x][y] = '.';
}

int main(void) {
	//freopen("input.txt", "r", stdin);
	int n, m;

	scanf("%d%d", &n, &m);
	for (int i = 0; i < n; i++)
		scanf("%s", &s[i]);

	memcpy(cs, s, sizeof(s));
	int ans = 0;
	n--;
	m--;

	if (!n && !m) {
		if (s[0][0] == '*') cout << 1;
		else cout << 0;
		return 0;
	}

	dfs(0, 0, n, m, false);
	if (sum[n][m] == -1) {
		cout << -1;
		return 0;
	}
	memcpy(csum, sum, sizeof(sum));

	for (int i = 0; i <= n; i++)
		for (int z = 0; z <= m; z++)
			if (csum[i][z] != -1) {
				memcpy(s, cs, sizeof(s));
				dfs(0, 0, i, z, true);
				if (sum[i][z] == -1) continue;
				delPath(0, 0, i, z);

				dfs(i, z, n, m, false);
				if (sum[n][m] == -1) continue;
				delPath(i, z, n, m);

				int currAns = sum[n][m];
				dfs(0, 0, n, m, true);
				currAns += sum[n][m];

				if (currAns > ans)
					ans = currAns;
			}

	printf("%d", ans);
}