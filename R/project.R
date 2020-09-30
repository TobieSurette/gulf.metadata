#' Project Identifiers
#'
#' @description Functions to retrieve or assign project identifiers to objects.
#'
#' @param x Target object.
#' @param ... Other arguments (not used).
#' @param value Character string(s) specifying the project identifier to be assigned.
#' @param verbose Logical value specifying whether to return a character string result in long form.
#'
#' @details The \code{project} attribute may be erased by assigning a \code{NULL} value to it.
#'
#' @return An object with a \code{project} attribute attached to it.
#'
#' @section Functions:
#' \describe{
#'   \item{\code{project}}{Generic \code{project} extraction method.}
#'   \item{\code{project.default}}{Default \code{project} extraction method.} 
#'   \item{\code{project.character}}{Find project name.} 
#'   \item{\code{project<-}}{Generic \code{project} assignment method.}
#'   \item{\code{project<-.default}}{Default \code{project} assignment method.}
#' }
#'
#' @examples
#' x <- data.frame(year = 2010:2014, measurement = rnorm(5))
#' project(x) <- "test.survey"
#'
#' # Show attributes:
#' attributes(x)
#'
#' # Erase 'project' attribute:
#' project(x) <- NULL   # Remove all projects.
#' 
#' # Load entire project table:
#' project()
#'
#' # Find project name in project table:
#' project("sc")
#' project("snow crab survey")
#' project("snow crab fecundity")
#' project("rv")
#' project("september survey") 
#' project("Northumberland") 
#' project("rv", verbose = TRUE) # Long form.
#'
#' @seealso \code{\link{metadata}}
#'

#' @export project
project <- function(x, ...) UseMethod("project")

#' @export
project.default <- function(x, ...){
   if (missing(x)){
      file <- locate(package = "gulf.metadata", "project.csv")
      v <- read.csv(file, header = TRUE, stringsAsFactors = FALSE)
      return(v)
   }
   
   return(attr(x, "project"))
}

#' @export 
project.character <- function(x, verbose = FALSE, ...){
   x <- tolower(x)
   if (!verbose) var <- "name" else var = "name.long"
         
   # Load project table:
   v <- project()
   
   # Search project names:
   index <- grep(paste0("^", x), v$name)
   if (length(index) > 1) index <- index[1]
   if (length(index) == 1) return(v[index, var])
   
   # Search project keywords:
   x <- strsplit(x, " ")[[1]]
   index <- 1:nrow(v)
   for (i in 1:length(x)) index <- intersect(index, grep(x[i], v$keywords))
   if (length(index) == 1) return(v[index, var])
                                  
   return(NULL)
}

#' @export "project<-" 
"project<-" <- function(x, ...) UseMethod("project<-")

#' @export
"project<-.default" <- function(x, value, ...){
   v <- project()
   if (!is.character(value) | (length(value) != 1)) stop("Project must be a single character string.")

   # Look up project identifier in reference table:
   if (any(tolower(value) == v$name)){
      i <- which(tolower(value) == v$name)
      keyword(x) <- deblank(strsplit(v$keywords[i], ";")[[1]])
      description(x) <- v$description[i]
   }
   
   # Assign project attribute:
   attr(x, "project") <- value
   
   return(x)
}



