##############################################################################
# Assignment : 5
# Author     : Lishan Huang
# Email      : lhuan22@uwo.ca
# 
# User module
##############################################################################
defmodule User do
  #enforce the structure fomular
  @enforce_keys [:username, :password]
  #define structure of User module
  defstruct [:username, :password]
end
