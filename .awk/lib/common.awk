# Math
function abs(num) { return (num > 0 ? num : -num) }
function max(a,b) { return (a > b ? a : b) }
function min(a,b) { return (a < b ? a : b) }

# Sorting
function qsort(A, left, right,   i, last) {
	if (left >= right)
		return
	last = left
	for (i = left+1; i <= right; i++)
		if (A[i] < A[left])
		swap(A, ++last, i)
	swap(A, left, last)
	qsort(A, left, last-1)
	qsort(A, last+1, right)
}

function swap(A, i, j,   t) {
	t = A[i]; A[i] = A[j]; A[j] = t 
}

# Escape "%" in strings to make it printable from printf()
function escape_p (s) {
	return gensub("%", "%%", "g", s)
}

# Delete trailing spaces at the left side of string s
function ltrim(s) {
	sub(/^ */, "", s)
	return s
}

# Delete trailing spaces at the right side of string s
function rtrim(s) {
	sub(/ *$/, "", s)
	return s
}

# Delete trailing spaces at both sides of string s
function trim(s) {
	return rtrim(ltrim(s))
}

# vim: set ft=awk:
