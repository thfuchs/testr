delete_space <- function(char){
  #Checks-------------------------------------------------------------------------
  assistant::check_class(char, "character", fun_name = "delete_space")
  #------------------------------------------------------------------------------- 
  stringr::str_replace_all(stringr::str_squish(char), stringr::fixed(" "), "")
}