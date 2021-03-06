## The two functions below allow calculating and caching the inverse of a
## matrix, so that in subsequent calls for the inverse of this matrix, the
## inverse can be pulled from the cache, rather than having to calculate the
## inverse a second time.

## The makeCacheMatrix function creates a list of four functions to get and set
## the source matrix and to get and set the inverse of that matrix.

makeCacheMatrix <- function(x = matrix()) {
    
    ## initialize the inverse to null
    i <- NULL
    
    ## store the input matrix and reset the inverse
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
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## The cacheSolve function gets the inverse of a matrix by first checking if the
## inverse has already been cached. If it isn't, it calculates the inverse
## and caches it, if it is, then it returns the cached inverse.

cacheSolve <- function(x, ...) {
    
    ## try to get the inverse of the matrix x
    i <- x$getinverse()
    
    ## If the object returned was not empty, then show a message that we're
    ## getting the answer from the cache and return the inverse
    if(!is.null(i)) {
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
