#' Check variable class for numeric / integer 
#'
#' Match variable class with one of numeric or integer and abort by
#'  `\link[rlang]{abort}` otherwise.
#'
#' @param var variable to check
#' @param allowNULL allow to pass check if var NULL? FALSE by default
#'
#' @return silent if check is passed, rlang error otherwise
#' @export
#'
#' @examples
#'   id <- 2
#'   check_num_int(id)
#'
#'   id <- 2L
#'   check_num_int(id)
#'
#'   # pass check if variable NULL
#'   id <- NULL
#'   check_num_int(id, allowNULL = TRUE)
#'
#'   \dontrun{
#'     # generates error
#'     id <- "2"
#'     check_num_int(id)
#'   }
#'
#' @export
check_num_int <- function(var, allowNULL = FALSE) {
  
  ### Checks -------------------------------------------------------------------
  
  # allowNULL required - logical
  if (!inherits(allowNULL, "logical")) rlang::abort(
    message = sprintf(
      "`allowNULL` must be logical, not of class \"%s\".",
      paste(class(allowNULL), collapse = " / ")
    ),
    class = "check_num_int_allowNULL_error",
    value = allowNULL
  )
  
  ### Function -----------------------------------------------------------------
  var_name <- deparse(substitute(var))
  fun_name <- if (sys.parent() > 0) deparse(sys.call(sys.parent())[[1]])
  
  if (
    # 1. allow NULL
    if (allowNULL) !is.null(var) && !rlang::inherits_any(var, c("numeric", "integer")) else
      # 2. Do not allow for NULL
      !rlang::inherits_any(var, c("numeric", "integer"))
  ) {
    rlang::abort(
      message = sprintf(
        "`%s` must be numeric or integer, not of class \"%s\".",
        var_name,
        paste(class(var), collapse = " / ")
      ),
      class = paste0(paste0(fun_name, "_", recycle0 = TRUE), var_name, "_error"),
      value = var,
      current_class = class(var)
    )
  }
}