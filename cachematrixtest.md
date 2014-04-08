cachematrix example
========================================================

generating three $3 \times 3$ matrices, $X1,X2$ and $X3$ with $X1 = X2 != X3$


```r
X1 <- matrix(1:4, 2, 2)
X2 <- matrix(1:4, 2, 2)
X3 <- matrix(2:5, 2, 2)
```


create a cache for inverse of matrix X1


```r
source("cachematrix.R")
makeCacheMatrix(X1)
```


test cases

```r
cacheSolve(X1)
```

```
## cache exists
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

```r
cacheSolve(X2)
```

```
## cache exists
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

```r
cacheSolve(matrix(1:4, 2, 2))
```

```
## cache exists
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

```r
cacheSolve(X3)
```

```
## cache does not exists
```

```
##      [,1] [,2]
## [1,] -2.5    2
## [2,]  1.5   -1
```

```r
cacheSolve(c(1, 2, 3, 4))
```

```
## [1] "invalid input"
```

