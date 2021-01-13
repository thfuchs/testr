#' Check variable class
#'
#' Match variable class with the one specified and abort by
#'  `\link[rlang]{abort}` otherwise.
#'
#' @param var variable to check
#' @param type class to check var for
#' @param fun_name required function name for error message, as character
#' @param n numeric to also check length var
#' @param allowNULL allow to pass check if var NULL? FALSE by default
#'
#' @return silent if check is passed, rlang error otherwise
#' @export
#'
#' @examples
#'   id <- "chr"
#'   check_class(id, "character")
#'
#'   id <- 2
#'   check_class(id, "numeric")
#'
#'   # check variable type and length
#'   check_class(id, "numeric", n = 1)
#'
#'   # pass check if variable NULL
#'   id <- NULL
#'   check_class(id, "character", allowNULL = TRUE)
#'
#'   \dontrun{
#'     # generates error
#'     id <- 2
#'     check_class(id, "character")
#'   }
#'
#' @export
check_class <- function(var,
                        type,
                        fun_name = NULL,
                        n = NULL,
                        allowNULL = FALSE) {

  ### Checks -------------------------------------------------------------------

  # type required - character
  if (!inherits(type, "character") || length(type) != 1)
    rlang::abort(
      message = sprintf(
        "`type` must be a character(1), not of class \"%s(%s)\".",
        paste(class(type), collapse = " / "),
        length(type)
      ),
      class = "check_class_type_error",
      value = type
    )

  # fun_name deprecated - character
  if (!is.null(fun_name)) message("`fun_name` in `check_class` is deprecated.")

  # n optional - NULL or numeric(1)
  if (!is.null(n) && (
    !rlang::inherits_any(n, c("numeric", "integer")) || length(n) != 1
  )) {
    rlang::abort(
      message = sprintf(
        "`n` must be numeric(1) or integer(1), not of class \"%s(%s)\".",
        paste(class(n), collapse = " / "),
        length(n)
      ),
      class = "check_class_n_error",
      value = n
    )
  }
  if (!is.null(n) && n < 0) {
    rlang::abort(
      message = sprintf("`n` must be not negative numeric(1) or integer(1)."),
      class = "check_class_n_error",
      value = n
    )
  }
  
  # allowNULL required - logical
  if (!inherits(allowNULL, "logical") || length(allowNULL) != 1) rlang::abort(
    message = sprintf(
      "`allowNULL` must be logical(1), not of class \"%s(%s)\".",
      paste(class(allowNULL), collapse = " / "),
      length(allowNULL)
    ),
    class = "check_class_allowNULL_error",
    value = allowNULL
  )

  ### Function -----------------------------------------------------------------
  var_name <- deparse(substitute(var))
  fun_name <- if (sys.parent() > 0) deparse(sys.call(sys.parent())[[1]])

  if (
    if (allowNULL) {
      # 1. allow NULL
      !is.null(var) && (!inherits(var, type) || (!is.null(n) && length(var) != n))
    } else {
      # 2. Do not allow for NULL
      !inherits(var, type) || (!is.null(n) && length(var) != n)
    }
  ) {
    rlang::abort(
      message = sprintf(
        "`%s` must be %s, not of class \"%s\".",
        var_name,
        if (is.null(n)) type else sprintf("%s(%s)", type, n),
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
