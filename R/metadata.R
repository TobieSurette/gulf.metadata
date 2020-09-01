#' Retrieve Metadata
#'
#' @description Function to retrieve metadata from an object.
#'
#' @param x Object.
#' @param ... Other arguments (not used).
#'
#' @examples
#' # Define sample data set:
#' x <- data.frame(year = 2010:2014,
#'                 site = letters[1:5],
#'                 weight = exp(rnorm(5)),
#'                 number = rpois(5,5))
#'
#' # Define metadata attributes:
#' units(x, "weight") <- "kilogram"
#' description(x) <- c(year = "Year of sampling",
#'                     site = "Sampling site",
#'                     weight = "Weight of specimen",
#'                     number = "Number observed")
#' format(x, "year") <- "YYYY"
#' key(x) <- "year"
#' keywords(x) <- c("annual", "survey")
#' 
#' # Retrieve metadata:
#' metadata(x)
#'
#' @section Methods:
#' \describe{
#'   \item{\code{\link{key}}}{Functions to assign, retrieve or check an index key for a given object.}
#'   \item{\code{\link{description}}}{Assign or retrieve a text description to an object.}
#'   \item{\code{\link{units}}}{Assigns or retrieves measurement units assigned to a data object.}
#'   \item{\code{\link{fmt}}}{Functions to assigns or retrieve data formatting information to and from an object.}
#'   \item{\code{\link{keyword}}}{Functions to assign, retrieve or look up object keyword attributes.}
#'   \item{\code{\link{project}}}{Functions to retrieve or assign project identifiers to objects.}   
#'   \item{\code{\link{header}}}{Function to assign and retrieve file header information associated with a data object.} 
#' }
#'
#' @export metadata
metadata <- function(x, ...) UseMethod("metadata")

#' @export 
metadata.data.frame <- function(x, ...){
   # Initialize output:
   res <- data.frame(attributeName = names(x),
                     attributeDefinition = "",
                     formatString = NA,
                     definition = "",
                     unit = NA,
                     numberType = NA,
                     stringsAsFactors = FALSE)

   # Extract attributes:
   res$attributeDefinition[match(names(attr(x, "description")), res$attributeName)] <- as.vector(attr(x, "description"))
   res$unit[match(names(attr(x, "units")), res$attributeName)] <- as.vector(attr(x, "units"))
   res$formatString[match(names(attr(x, "format")), res$attributeName)] <- as.vector(attr(x, "fmt"))

   return(res)
}
