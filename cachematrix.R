# Example usage:
# > x <- matrix(rnorm(16), nrow = 4)          // Create a matrix x
# > cx <- makeCacheMatrix(x)                  // Create our special matrix
# > cx$get()                                  // Return the matrix
# > cacheSolve(cx)                            // Return the inverse
# > cacheSolve(cx)                            // Call the 2nd time, so return
#                                             // the cached inverse


# makeCacheMatrix: return a list of functions to:
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
	# inv will store the cached inverse matrix
    i <- NULL

      # setter for the matrix
    set <- function(y) {
        x <<- y
        i <<- NULL
    }

 	# getter for the matrix 

    get <- function() x
	#setter for the inverse

    setinverse <- function(inv) i <<- inv
  
 	# getter for the inverse
    getinverse <- function() i
    list(
        set = set,
        get = get,
        setinverse = setinverse,
        getinverse = getinverse
    )
}


# cacheSolve: Compute the inverse of the matrix. If the inverse is already
# calculated before, it returns the cached inverse.

cacheSolve <- function(x, ...) {
    i <- x$getinverse()

	# If the inverse is already calculated, return it
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
	# The inverse is not yet calculated, so we calculate it
    m <- x$get()
    i <- solve(m, ...)
	# Cache the inverse
    x$setinverse(i)
	# Return it
    i
}