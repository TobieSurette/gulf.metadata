#' Data Description
#'
#' @description Assign or retrieve a text description to an object.
#'
#' @param x Target object.
#' @param y Character string(s) specifying the name(s) of the variables or attributes to be assigned a description string.
#' @param ... Other arguments (not used).
#' @param value Character string(s) specifying the text description to be assigned.
#'
#' @details The \code{description} attribute may be erased by assigning a \code{NULL} value to it.
#'
#' @return An object with a \code{description} attribute attached to it.
#'
#' @section Functions:
#' \describe{
#'   \item{\code{description}}{Generic \code{description} retrieval method.}
#'   \item{\code{description.default}}{Default \code{description} retrieval method.}
#'   \item{\code{description<-}}{Generic \code{description} assignment method.}
#'   \item{\code{description<-.default}}{Default \code{description} assignment method.}
#' }
#'
#' @examples
#' x <- data.frame(year = 2010:2014, measurement = rnorm(5))
#' description(x) <- "A simple table"
#' description(x, "year") <- "Year the sample was taken."
#' description(x, "measurement") <- "Length of the specimen."
#'
#' # ... or equivalently:
#' description(x, c("year", "measurement")) <- c("Year the sample was taken.",
#'   "Length of the specimen.")
#' description(x) <- c(year = "Year the sample was taken.",
#'   measurement = "Length of the specimen.")
#' description(x) <- list(year = "Year the sample was taken.",
#'   measurement = "Length of the specimen.")
#'
#' # Show attributes:
#' attributes(x)
#'
#' # Erase 'description' attribute:
#' description(x, "year") <- NULL  # Remove 'year' description.
#' description(x) <- NULL          # Remove all descriptions.
#'
#' @seealso \code{\link{metadata}}

#' @export
description <- function(x, ...) UseMethod("description")

#' @export
description.default <- function(x, ...) return(attr(x, "description"))

#' @export
"description<-" <- function(x, ...) UseMethod("description<-")

#' @export
"description<-.default" <- function(x, y, value, ...){
   if (missing(y)){
      # Extract attributes fields from 'value':
      if (!is.null(names(value))){
         description(x, names(value)) <- value
         return(x)
      }
      # Assign attribute:
      attr(x, "description") <- value
   }else{
      if (!is.character(y)) stop("Named argument must be a character string(s).")
      if (!all(y %in% names(x))) stop("Named argument must be in target object.")
      tmp <- attr(x, "description")
      if (is.null(value)){
         tmp <- tmp[setdiff(names(tmp), y)]
      }else{
         if ((length(value) == 1) & (length(y) > 1)) value <- rep(value, length(y))
         if (length(y) != length(value)) stop("Named arguments must be the same length as assigned values.")
         tmp[y] <- as.vector(value)
      }
      attr(x, "description") <- tmp
   }

   return(x)
}

