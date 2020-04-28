#' Delete all space in character vector
#' 
#' Deletes all empty space and all breaks in a character vector. This can be 
#' usefull when applying `expect_eqal` on character strings.
#'
#' @param char A characte vector.
#'
#' @return `char` without all its empty spaces and breaks.
#' @export
#'
#' @example examples/example_delete_space.R
#' 
delete_space <- function(char){
  #Checks-------------------------------------------------------------------------
  assistant::check_class(char, "character", fun_name = "delete_space")
  #------------------------------------------------------------------------------- 
  stringr::str_replace_all(stringr::str_squish(char), stringr::fixed(" "), "")
}sds