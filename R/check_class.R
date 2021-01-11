#' Check variable class
#'
#' Match variable class with the one specified and abort by
#'  `\link[rlang]{abort}` otherwise.
#'
#' @param var variable to check
#' @param type class to check var for
#' @param fun_name required function name for error message, as character
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
check_class <- function(var, type, fun_name = NULL, allowNULL = FALSE) {

  ### Checks -------------------------------------------------------------------

  # type required - character
  if (!inherits(type, "character"))
    rlang::abort(
      message = sprintf(
        "`type` must be a character string, not of class \"%s\".",
        paste(class(type), collapse = " / ")
      ),
      class = "check_class_type_error",
      value = type
    )
  # fun_name deprecated - character
  if (!is.null(fun_name)) message("`fun_name` in `check_class` is deprecated.")
  # allowNULL required - logical
  if (!inherits(allowNULL, "logical")) rlang::abort(
    message = sprintf(
      "`allowNULL` must be logical, not of class \"%s\".",
      paste(class(allowNULL), collapse = " / ")
    ),
    class = "check_class_allowNULL_error",
    value = allowNULL
  )

  ### Function -----------------------------------------------------------------
  var_name <- deparse(substitute(var))
  fun_name <- if (sys.parent() > 0) deparse(sys.call(sys.parent())[[1]])

  if (
    # 1. allow NULL
    if (allowNULL) !is.null(var) && !inherits(var, type) else
      # 2. Do not allow for NULL
      !inherits(var, type)
  ) {
    rlang::abort(
      message = sprintf(
        "`%s` must be %s, not of class \"%s\".",
        var_name,
        type,
        paste(class(var), collapse = " / ")
      ),
      class = paste0(paste0(fun_name, "_", recycle0 = TRUE), var_name, "_error"),
      value = var,
      current_class = class(var)
    )
  }
}
