#' Check variable class for numeric / integer
#'
#' Match variable class with one of numeric or integer and abort by
#'  `\link[rlang]{abort}` otherwise.
#'
#' @param var variable to check
#' @param n numeric to also check length var  
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
#'   # check variable type and length
#'   check_num_int(id, n = 1)
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
check_num_int <- function(var, n = NULL, allowNULL = FALSE) {

  ### Checks -------------------------------------------------------------------

  # n optional - NULL or numeric(1)
  if (!is.null(n) && (!rlang::inherits_any(n, c("numeric", "integer")) || length(n) != 1)) {
    rlang::abort(
      message = sprintf(
        "`n` must be numeric(1) or integer(1), not of class \"%s(%s)\".",
        paste(class(n), collapse = " / "),
        length(n)
      ),
      class = "check_num_int_n_error",
      value = n
    ) 
  }
  if (!is.null(n) && n < 0) {
    rlang::abort(
      message = sprintf("`n` must be not negative numeric(1) or integer(1)."),
      class = "check_num_int_n_error",
      value = n
    ) 
  }
  
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
    if (allowNULL) {
      # 1. allow NULL
      !is.null(var) && (
        !rlang::inherits_any(var, c("numeric", "integer")) || (!is.null(n) && length(var) != n))
    } else {
      # 2. Do not allow for NULL
      !rlang::inherits_any(var, c("numeric", "integer")) || (!is.null(n) && length(var) != n)
    }
  ) {
    rlang::abort(
      message = sprintf(
        "`%s` must be %s or %s, not of class \"%s\".",
        var_name,
        if (is.null(n)) "numeric" else sprintf("numeric(%s)", n),
        if (is.null(n)) "integer" else sprintf("integer(%s)", n),
        if (is.null(n)) {
          paste(class(var), collapse = " / ")
        } else {
          sprintf("%s(%s)", paste(class(var), collapse = " / "), length(var)) 
        }
      ),
      class = paste0(paste0(fun_name, "_", recycle0 = TRUE), var_name, "_error"),
      value = var,
      current_class = class(var)
    )
  }
}
