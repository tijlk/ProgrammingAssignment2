Caching the inverse of a matrix
========================================================

The two functions below allow calculating and caching the inverse of a matrix, so that in subsequent calls for the inverse of this matrix, the inverse can be pulled from the cache, rather than having to calculate the inverse a second time.

The makeCacheMatrix function below creates a list of four functions to get and set the source matrix and to get and set the inverse of that matrix.


```r
makeCacheMatrix <- function(x = matrix()) {
    
    ## initialize the inverse to null
    i <- NULL
    
    ## ??
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    
    ## get the original matrix x
    get <- function() x
    
    ## sets the inverse of matrix x to i
    setinverse <- function(solve) i <<- solve
    
    ## gets the inverse matrix i
    getinverse <- function() i
    
    ## return the list of 4 functions
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}
```


The cacheSolve function gets the inverse of a matrix by first checking if the inverse has already been cached. If it isn't, it calculates the inverse and caches it, if it is, then it returns the cached inverse.


```r
cacheSolve <- function(x, ...) {
    
    ## try to get the inverse of the matrix x
    i <- x$getinverse()
    
    ## If the object returned was not empty, then show a message that we're
    ## getting the answer from the cache and return the inverse
    if (!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    
    ## if the object returned WAS empty, then get the original matrix
    data <- x$get()
    
    ## now calculate the inverse of this matrix
    i <- solve(data, ...)
    
    ## and add it to the cache
    x$setinverse(i)
    
    ## lastly, return the calculated inverse
    i
}
```


Now we make a 5-by-5 matrix to test this procedure on:


```r
m = matrix(rnorm(25), 5, 5)
m
```

```
##          [,1]     [,2]     [,3]     [,4]    [,5]
## [1,]  0.94449 -0.11800 -1.19903  0.05624  1.9710
## [2,]  0.07184  1.27002 -1.67492  0.90750  1.3502
## [3,]  0.61829 -0.34881 -0.62432 -0.02031 -0.9371
## [4,]  1.95025  0.39291 -0.92078  0.65175 -1.1732
## [5,] -0.36998  0.04469  0.03779  0.47165  1.1308
```


Let's see:


```r
x = makeCacheMatrix(m)
i = cacheSolve(x)
i
```

```
##          [,1]     [,2]    [,3]      [,4]    [,5]
## [1,]  0.33610 -0.29575 -0.6324  0.520187 -0.2171
## [2,] -0.10117  0.39783 -1.2735  0.225617 -1.1200
## [3,] -0.06598 -0.39946 -0.9673  0.390397  0.1953
## [4,] -0.47340 -0.05578  0.6110  0.377042  1.7893
## [5,]  0.31362 -0.07588 -0.3791 -0.009028  0.1047
```


And let's verify the results by calcuting the matrix product of the original matrix and its inverse which should return the identity matrix:

```r
format(round(i %*% m, 0), nsmall = 0)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,] "1"  "0"  "0"  "0"  "0" 
## [2,] "0"  "1"  "0"  "0"  "0" 
## [3,] "0"  "0"  "1"  "0"  "0" 
## [4,] "0"  "0"  "0"  "1"  "0" 
## [5,] "0"  "0"  "0"  "0"  "1"
```



