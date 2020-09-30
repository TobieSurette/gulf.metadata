#' Assign or Retrieve Data Format
#'
#' @description Functions to assigns or retrieve data formatting information to and from an object.
#' 
#' @param x Target object.
#' @param y Character string(s) specifying the name(s) of the variables or attributes to be assigned data formats.
#' @param value Character string(s) specifying the data format to be assigned.
#' @param ... Other arguments (not used).
#'
#' @details Named argiments in the format that are not in the target object are ignored.
#'          The \code{fmt} attribute may be erased by assigning a \code{NULL} or empty 
#'          string \code{""} value to it.
#'
#' @return Object with a format \code{fmt} attribute attached to it.
#' 
#' @examples
#' x <- data.frame(year = 2010:2014, month = 6, day = 1:5, measurement = rnorm(5))
#' fmt(x, "year")  <- "YYYY"
#' fmt(x, "month") <- "MM"
#' fmt(x, "day")   <- "DD"
#'
#' # Equivalently:
#' fmt(x) <- c(year = "YYYY", month = "MM", day = "DD")
#' fmt(x, c("year", "month", "day")) <- c("YYYY", "MM", "DD")
#'
#' # Show attributes:
#' attributes(x)
#' fmt(x)
#'
#' # Erase 'fmt' attribute:
#' fmt(x) <- NULL
#' 
#' @seealso \code{\link{metadata}}
#' 
#' @section Functions:
#' \describe{
#'   \item{\code{fmt}}{Generic \code{fmt} method.}
#'   \item{\code{fmt.default}}{Default \code{fmt} method.}
#'   \item{\code{fmt<-}}{Generic format assignment method.}
#'   \item{\code{fmt<-.default}}{Default format assignment method. See Examples for usage.} 
#' }
#' 
#' @export fmt
"fmt" <- function(x, ...) UseMethod("fmt")

#' @export
fmt.default <- function(x, ...) return(attr(x, "fmt"))

#' @export "fmt<-"
"fmt<-" <- function(x, ...) UseMethod("fmt<-")

#' @export
"fmt<-.default" <- function(x, y, value, ...){
   if (missing(y)){
      # Extract attributes fields from 'value':
      if (!is.null(names(value))){
         fmt(x, names(value)) <- value
         return(x)
      }
      # Assign attribute:
      attr(x, "fmt") <- value
   }else{
      if (!is.character(y)) stop("Named argument must be a character string(s).")
     # if (!any(y %in% names(x))) stop("Named argument must be in target object.")
      tmp <- attr(x, "fmt")
      if (!is.null(value)) if (all(value == "")) value <- NULL
      if (is.null(value)){
         tmp <- tmp[setdiff(names(tmp), y)]
      }else{
         if ((length(value) == 1) & (length(y) > 1)) value <- rep(value, length(y))
         if (length(y) != length(value)) 
            stop("Named arguments must be the same length as assigned values.")
         i <- y %in% names(x)
         y <- y[i]; value <- value[i]
         tmp[y] <- as.vector(value)
      }
      attr(x, "fmt") <- tmp
   }

   return(x)
}
