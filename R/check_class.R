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
#'   check_class(id, "character", fun_name = "function")
#'
#'   id <- 2
#'   check_class(id, "numeric", fun_name = "fun")
#'
#'   # pass check if variable NULL
#'   id <- NULL
#'   check_class(id, "character", fun_name = "function", allowNULL = TRUE)
#'
#'   \dontrun{
#'     # generates error
#'     id <- 2
#'     check_class(id, "character", fun_name = "function")
#'   }
#'
#' @export
check_class <- function(var, type, fun_name, allowNULL = FALSE) {

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
  # fun_name required - character
  if (!inherits(fun_name, "character"))
    rlang::abort(
      message = sprintf(
        "`fun_name` must be a character string, not of class \"%s\".",
        paste(class(fun_name), collapse = " / ")
      ),
      class = "check_class_fun_name_error",
      value = fun_name
    )
  # allowNULL required - logical
  if (!inherits(allowNULL, "logical"))
    rlang::abort(
      message = sprintf(
        "`allowNULL` must be logical, not of class \"%s\".",
        paste(class(allowNULL), collapse = " / ")
      ),
      class = "check_class_allowNULL_error",
      value = allowNULL
    )

  ### Function -----------------------------------------------------------------
  var_name <- deparse(substitute(var))

  if (
    # 1. allow NULL
    if (allowNULL) {
      !is.null(var) && !inherits(var, type)
    } else
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
      class = sprintf("%s_%s_error", fun_name, var_name),
      value = var,
      current_class = class(var)
    )
  }
}