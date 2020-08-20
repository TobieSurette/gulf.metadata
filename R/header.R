#' File Header Information
#' 
#' @description Extracts header information from certain data files.
#' 
#' @param x File name or object.
#'
#' @section Functions:
#' \describe{
#'   \item{\code{header}}{Default \code{header} method.}
#'   \item{\code{header.default}}{Default \code{header} retrieval method.}
#'   \item{\code{header<-}}{Generic \code{header} assignment method. See Examples for usage.}
#'   \item{\code{header<-.default}}{Default\code{header} assignment method. See Examples for usage.} 
#' }
#'   
#' @examples 
#' 
#' @seealso \code{\link[gulf.data]{minilog}}
#' 

#' @export
header <- function(x, ...) UseMethod("header")

#' @export
header.default <- function(x) return(attr(x, "header"))

#' @export
"header<-" <- function(x, ...) UseMethod("header<-")

#' @export
"header<-.default" <- function(x, value){
   if (is.null(value) | length(value) == 0) attr(x, "header") <- NULL
   if (!is.null(value)) attr(x, "header") <- value
   if (!is.character(value)) stop("Keywords must be a character string(s).")
   if (length(value) == 1) if (value == "") attr(x, "header") <- NULL

   return(x)
}


