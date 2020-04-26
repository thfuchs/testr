# No error and correct output for correct input---------------------------------

#all default
expect_silent(delete_space("a"))
expect_true(inherits(delete_space("a"), "character"))

#Error for wrong input----------------------------------------------------------

#name-of-tested-variable
expect_error(delete_space(1))
err <- tryCatch(delete_space(1),
                error = function(err) err)
expect_true(rlang::inherits_all(
  err,c("delete_space_char_error", "rlang_error")
))
expect_equal(err$value, 1)
expect_equal(err$current_class, "numeric")
