terraform {}

# Number list
variable "num_list" {
  type = list(number)

  default = [ 1, 2, 3, 4, 5 ]
}

# Object list of person 
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))

  default = [ 
    {
      fname = "Shubham"
      lname = "Passi"
    },
    {
      fname = "Jatin"
      lname = "Passi"
    }
  ]
}

# Map usecase
variable "map_list" {
  type = map(number)

  default = {
    "one" = 1
    "two" = 2
    "three" = 3
  }
}

# Calculation
locals {
  mul = 2 * 2
  add = 2 + 2
  eq = 2 != 3

  # Double the num list
  double = [ for num in var.num_list : num * 2 ]

  # Odd numbers only
  odd = [ for num in var.num_list : num if num % 2 == 0 ]

  # Person's first name from object
  fname_list = [ for person in var.person_list : person.fname ]

  # working with map
  map_info_key = [ 
    for key, value in var.map_list : 
      key
  ]
  map_info_val = {
    for key, value in var.map_list : 
      "${key}" => "${value}" *2
  }

}
 
output "output" {
  value = local.map_info_val
}