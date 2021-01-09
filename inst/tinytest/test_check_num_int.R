### Pass test ------------------------------------------------------------------

# type
expect_silent(check_num_int(2))
expect_silent(check_num_int(c(1,2,3)))
expect_silent(check_num_int(as.integer(c(1,2,3))))

# allowNULL (Exception from e.g. character)
expect_silent(check_num_int(NULL, allowNULL = TRUE))

### Errors ---------------------------------------------------------------------

# var
expect_error(check_num_int())

# allowNULL
expect_error(check_num_int(id, allowNULL = "x"), class = "check_num_int_allowNULL_error")
expect_error(check_num_int(id, allowNULL = NULL), class = "check_num_int_allowNULL_error")
expect_error(check_num_int(id, allowNULL = 12), class = "check_num_int_allowNULL_error")
