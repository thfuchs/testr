tinytest::expect_equal(
  "abcd",
  "a  b    c
  d"
)

tinytest::expect_equal(
  "abcd",
  delete_space(
    "a  b    c
  d"
  )
)