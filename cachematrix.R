## The makeCacheMatrix function creates a list of four functions to get and set
## the source matrix and to get and set the inverse of that matrix. The
## cacheSolve function gets the inverse of a matrix by first checking if the
## inverse has already been cached. If it isn't, it calculates the inverse
## and caches it, if it is, then it returns the cached inverse.

## Write a short comment describing this function

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
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    
    ## Return a matrix that is the inverse of 'x'
    
    i <- x$getinverse()
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinverse(i)
    i
}
