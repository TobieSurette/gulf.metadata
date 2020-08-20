#' Keyword Functions
#'
#' @description Functions to assign, retrieve or look up object keyword attributes.
#'
#' @param x Object.
#' @param ... Other arguments (not used).
#' @param value Character string(s) specifying the index key to be assigned.
#' 
#' @section Functions:
#' \describe{
#'   \item{\code{keyword}}{Default \code{key} method.}
#'   \item{\code{keyword.default}}{Default \code{format} retrieval method. If no \code{key} attribute is 
#'                             defined, then a call to \code{\link[base]{format}} is made.}
#'   \item{\code{key<-}}{Generic \code{key} assignment method. See Examples for usage.}
#'   \item{\code{key<-.default}}{Default\code{key} assignment method. See Examples for usage.} 
#' }
#' 
#' @examples
#' # Build sample data:
#' x <- data.frame(year = 1990:2014, measurement = rpois(25, 5))
#' keyword(x) <- c("Annual", "survey") # Assign keywords
#' keyword(x) # Retrieve key.
#'
#' @seealso \code{\link{metadata}}, \code{\link{description}}, \code{\link{units}}, \code{\link[gulf.metadata]{format}}
#'

#' @export
keyword <- function(x, ...) UseMethod("keyword")

#' @export
keyword.default <- function(x, ...) return(attr(x, "keyword"))

#' @export
"keyword<-" <- function(x, ...) UseMethod("keyword<-")

#' @export
"keyword<-.default" <- function(x, value){
   if (is.null(value)) attr(x, "keyword") <- value
   if (!is.character(value)) stop("Keywords must be a character string(s).")
   if (length(value) == 1) if (value == "") attr(x, "keyword") <- NULL
   value <- value[value != ""]
   if (length(value) > 0) attr(x, "keyword") <- tolower(gulf.utils::deblank(value))

   return(x)
}
