#include <cstdio>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <utility>
using std::vector;
using std::pair;
using std::min;

// Finding index of X in matrix
int findIndexOf(int** matrix, int u, int x) {
	for (int i = 0; i < u; i++) {
		if (matrix[i][0] == x)  return i;
	}
	return -1;
}

// Coping from matrix to dest array scr-line where indexes is index-line
void indexCopy(int** matrix, int* dest, int m, int index, int src) {
	for (int i = 1; i <= m; i++) {
		dest[matrix[index][i]] = matrix[src][i];
	}
}

// Merging solve
int mergeAndCount(int* b, int* m, int* e, int* tmp) {
	int counter = 0; // Count of inversion
	int* p1 = tmp; // Pointer for 1st array
	int* p2 = m; // Pointer for 2nd array
	int* cp = b; // Current pointet
	int* eTmp = tmp + (m - b); // End of tmp array

	memcpy(tmp, b, (m - b) * sizeof(int));
	while (p1 != eTmp && p2 != e) {
		if (*p1 <= *p2) {
			*cp = *p1;
			p1++;
		}
		else {
			*cp = *p2;
			counter += (eTmp - p1);
			p2++;
		}
		cp++;
	}

	while (p1 != eTmp) {
		*cp = *p1;
		cp++; 
		p1++;
	}

	while (p2 != e) {
		*cp = *p2;
		cp++;
		p2++;
	}

	return counter;
}

// Insertion sort
int insertionSortAndCount(int* b, int* e) {
	int counter = 0;
	int size = e - b;

	for (int i = 1; i < size; i++) {
		int pos = i;
		while (pos && b[pos] < b[pos - 1]) {
			std::swap(b[pos], b[pos - 1]);
			pos--;
			counter++;
		}
	}

	return counter;
}

// Merge sort
int mergeSortAndCount(int* b, int* e) {
	int* tmp = new int[e - b]; // temporary array for merge
	int counter = 0;
	int size = e - b;

	int blockSize = 64;
	for (int i = 0; i < size; i += blockSize) {
		counter += insertionSortAndCount(b + i, b + min(i + blockSize, size));
	}

	while (blockSize < size) {
		for (int i = 0; i + blockSize < size; i += blockSize * 2) {
			counter += mergeAndCount(b + i, b + i + blockSize, b + min(i + 2 * blockSize, size), tmp);
		}
		blockSize <<= 1;
	}

	delete[] tmp;
	return counter;
}

void findAns(vector< pair<int, int> >& ans, int** matrix, int u, int m, int x) {
	int* tmp = new int[m + 1];

	for (int i = 0; i < u; i++) {
		if (i == x) continue;

		indexCopy(matrix, tmp, m, x, i);
		int count = mergeSortAndCount(tmp + 1, tmp + m + 1);

		ans.push_back(std::make_pair(count, matrix[i][0]));
	}

	delete[] tmp;
}

// Outputting data
void output(vector< pair<int, int> >& ans, int x) {
	std::sort(ans.begin(), ans.end());
	printf("%d\n", x);
	for (int i = 0; i < ans.size(); i++)
		printf("%d %d\n", ans[i].second, ans[i].first);
}


int main(int argc, char* argv[]) {
	
	if (argc != 2) exit(-1);
	int x = atoi(argv[1]);
	//int x = 719;
	//freopen("input.txt", "r", stdin);

	int u, m;
	scanf("%d%d", &u, &m);

	int** matrix = new int* [u];
	for (int i = 0; i < u; i++) {
		matrix[i] = new int [m + 1];
	}

	for (int i = 0; i < u; i++) {
		for (int z = 0; z < (m + 1); z++) {
			scanf("%d", &matrix[i][z]);
		}
	}

	x = findIndexOf(matrix, u, x);
	if (x == -1) exit(-2);

	vector< pair<int, int> > ans;
	findAns(ans, matrix, u, m, x);

	output(ans, matrix[x][0]);

	for (int i = 0; i < u; i++) {
		delete[] matrix[i];
	}
	delete[] matrix;
}