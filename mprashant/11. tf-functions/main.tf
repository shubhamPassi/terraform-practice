locals {
  print = "Hello World"
}

variable "string_list" {
  type = list(string)
  default = [ "value1", "value2", "value3", "value1" ]
}

output "output" {
    # value = lower(local.print)                        # output => "hello world"
    # value = upper(local.print)                        # output => "HELLO WORLD"
    # value = split(" ", local.print)                   # output => ["Hello", "World"]
    # value = min(3, 2, 4, 2, 5, 8)                     # output => 2
    # value = max(3, 2, 4, 2, 5, 8)                     # output => 8
    # value = abs(-15.23)                               # output => 15.23
    # value = length(var.string_list)                   # output => 3
    # value = join("$", var.string_list)                # output = "value1$value2$value3"
    # value = contains(var.string_list, "value2")       # output = true
    value = toset(var.string_list)                      # [ "value1", "value2", "value3" ]
}