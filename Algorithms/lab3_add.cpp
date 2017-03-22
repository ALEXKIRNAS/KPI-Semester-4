#include <cstdio>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include <utility>
#include <time.h>
using namespace std;

// QuickSort 1 pivot
template <class T>
int partition1(T* (&b), T* (&e), T* (&wall)) {
	const T* pivot = e - 1;
	int counter = 0;

	for (T* i = b; i != pivot; i++) {
		++counter;
		if (*i <= *pivot) {
			swap(*i, *wall);
			++wall;
		}
	}

	swap(*(e - 1), *wall);
	return counter;
}

template <class T>
int quickSort1(T* b, T* e) {
	if (e <= b) return 0;

	T* wall = b;
	int counter = partition1(b, e, wall);

	counter += quickSort1(b, wall);
	counter += quickSort1(wall + 1, e);
	return counter;
}

// --------------------------------------------------------------------
// QuickSort 3-way pivot

template <class T>
void swapPivots(T* (&b), T* (&e), pair<T, int> arr[3]) {
	arr[0].first = *b; arr[0].second = 0;
	arr[1].first = *(e - 1); arr[1].second = (e - b) - 1;
	arr[2].first = *(b + (e - b) / 2); arr[2].second = (e - b) / 2;
	sort(arr, arr + 3);
	swap(*(e - 1), b[arr[1].second]);
}

template <class T>
int partition13(T* (&b), T* (&e), T* (&wall)) {
	pair <T, int> arr[3];
	swapPivots(b, e, arr);

	const T* pivot = e - 1;
	int counter = 0;

	for (T* i = b; i != pivot; i++) {
		++counter;
		if (*i <= *pivot) {
			swap(*i, *wall);
			++wall;
		}
	}

	swap(*(e - 1), *wall);
	return counter;
}

template <class T>
int quickSort13(T* b, T* e) {
	if ((e - b) <= 3) {
		return quickSort1(b, e);
	}

	T* wall = b;
	int counter = partition13(b, e, wall);

	counter += quickSort13(b, wall);
	counter += quickSort13(wall + 1, e);
	return counter;
}

//--------------------------------------------------------------------------
// QuickSort 3 pivot

template <class T>
void swapPivots(T* b, T* e, T** pivot) {
	pivot[0] = b;
	pivot[1] = b + 1;
	pivot[2] = e - 1;
	if (*pivot[0] > *pivot[1]) swap(*pivot[0], *pivot[1]);
	if (*pivot[1] > *pivot[2]) swap(*pivot[1], *pivot[2]);
	if (*pivot[0] > *pivot[1]) swap(*pivot[0], *pivot[1]);
}

template <class T>
int leftPartition(T* (&a), T* (&b), T* (&c), T& p, T& q) {
	int counter = 1;
	while (*b < q && b <= c) {
		if (*b < p) {
			swap(*a, *b);
			a++;
		}
		b++;
		counter += 2;
	}
	return counter;
}

template <class T>
int rightPartition(T* (&b), T* (&c), T* (&d), T& q, T& r) {
	int counter = 1;
	while (*c > q && b <= c) {
		if (*c > r) {
			swap(*c, *d);
			d--;
		}
		c--;
		counter += 2;
	}
	return counter;
}

template <class T>
int partition3(T* beg, T* end, int result [3]) {
	T* pivots[3];
	swapPivots(beg, end, pivots);
	T p = *pivots[0];
	T q = *pivots[1];
	T r = *pivots[2];

	T* a = beg + 2; T* b = beg + 2;
	T* c = end - 2; T* d = end - 2;
	int counter = 0;

	while (b <= c) {
		counter += leftPartition(a, b, c, p, q);
		counter += rightPartition(b, c, d, q, r);

		if (b <= c) {
			swap(*b, *c);
			if (*b < p) {
				swap(*a, *b);
				a++;
			}
			if (*c > r) {
				swap(*c, *d);
				d--;
			}
			b++; c--;
			counter += 2;
		}
	}

	a--; b--; d++;
	swap(beg[1], *a);
	swap(*a, *b);
	result[1] = b - beg;

	a--; 
	swap(*beg, *a); 
	result[0] = a - beg;
	swap(*(end - 1), *d);
	result[2] = d - beg;

	return counter;
}

template <class T>
int quickSort3(T* b, T* e) {
	if ((e - b) <= 2) {
		if ((e - b) == 2) {
			if (*b > *(b + 1)) swap(*b, *(b + 1));
			return 1;
		} else {
			return 0;
		}
	}

	T* p; T* q; T* r;
	int res[3];
	int counter = partition3(b, e, res);
	p = b + res[0]; q = b + res[1]; r = b + res[2];

	counter += quickSort3(b, p);
	counter += quickSort3(p + 1, q);
	counter += quickSort3(q + 1, r);
	counter += quickSort3(r + 1, e);

	return counter;
}

//--------------------------------------------------------------------------
// QuickSort 2 pivot

template <class T> 
int partition2(T* begin, T* end, int cb[2]) {
	if (*begin > *(end - 1)) swap(*begin, *(end - 1));
	T p = *begin; T q = *(end - 1);
	T* a = begin + 1; T* b = end - 2;
	T* c = begin + 1;

	int counter = 0;
	while (c <= b) {
		if (*c < p) {
			swap(*c, *a);
			a++;
			counter += 1;
		}
		else if (*c > q) {
			swap(*c, *b);
			b--;
			counter += 2;
		}
		c++;
	}

	swap(*begin, *a);
	swap(*(end - 1), *b);
	cb[0] = a - begin;
	cb[1] = b - begin;
	return counter;
}

template <class T>
int partition2Left(T* (&a), T* (&b), T* (&c), T& p, T& q) {
	int counter = 1;
	while (b <= c && *b < q) {
		if (*b < p) {
			swap(*a, *b);
			a++;
		}
		counter += 2;
	}
	return counter;
}

template <class T>
int partition2Right(T* (&b), T* (&c), T* (&d), T& p, T& q) {
	int counter = 1;
	while (b <= c && *c > p) {
		if (*c > q) {
			swap(*c, *d);
			d--;
		}
		counter += 2;
	}
	return counter;
}

template <class T>
int partition2Alt(T* begin, T* end, int cb[2]) {
	if (*begin > *(end - 1)) swap(*begin, *(end - 1));
	T p = *begin; T q = *(end - 1);
	T* a = begin + 1; T* b = end - 2;
	T* c = begin + 1; T* d = end - 2;

	int counter = 0;
	while (b <= c) {
		counter += partition2Left(a, b, c, p, q);
		counter += partition2Right(b, c, d, p, q);

		if (b <= c) {
			swap(*b, *c);
			if (*b < p) {
				swap(*a, *b);
				a++;
			}
			if (*c > q) {
				swap(*c, *d);
				d--;
			}
			counter += 2;
			b++; c--;
		}
	}

	swap(*begin, *a);
	swap(*(end - 1), *d);
	cb[0] = a - begin;
	cb[1] = d - begin;
	return counter;
}

template <class T>
int quickSort2(T* b, T* e) {
	if ((e - b) <= 2) {
		return quickSort1(b, e);
	}

	int cb[2];
	int counter = partition2(b, e, cb);
	T* p = b + cb[0]; T* q = b + cb[1];

	counter += quickSort2(b, p);
	counter += quickSort2(p + 1, q);
	counter += quickSort2(q + 1, e);

	return counter;
}

template <class T>
int quickSort2Alt(T* b, T* e) {
	if ((e - b) <= 2) {
		return quickSort1(b, e);
	}

	int cb[2];
	int counter = partition2Alt(b, e, cb);
	T* p = b + cb[0]; T* q = b + cb[1];

	counter += quickSort2(b, p);
	counter += quickSort2(p + 1, q);
	counter += quickSort2(q + 1, e);

	return counter;
}

//--------------------------------------------------------------------------

unsigned int test(int* b, int* e, int (*func) (int*, int*), char* lable) {
	const int size = e - b;
	int* tmp = new int[size];
	memcpy(tmp, b, sizeof(int) * (size));

	clock_t start = clock();
	int counter = func(tmp, tmp + size);
	clock_t end = clock();

	unsigned int res = end - start;
	#ifdef DEBUG
	for (int* i = b; i < e; i++) {
		printf("%d\n", tmp[i - b]);
		}
	#endif // DEBUG

	printf("%s: %d, %d ms\n", lable, counter, res);
	return res;
}

int main(int argc, char* argv[]) {
	int n;
	scanf("%d", &n);

	int* arr = new int[n];
	for (int i = 0; i < n; i++) {
		scanf("%d", &arr[i]);
	}

	test(arr, arr + n, quickSort1, "QuickSort");
	test(arr, arr + n, quickSort13, "QuickSort (3-way pivot)");
	test(arr, arr + n, quickSort2, "QuickSort (2 pivot)");
	test(arr, arr + n, quickSort2Alt, "QuickSort (2 pivot alternative)");
	test(arr, arr + n, quickSort3, "QuickSort (3 pivot)");
}